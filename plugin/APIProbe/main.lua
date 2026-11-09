-- Vendetta Online API observation plugin.
-- Nothing is captured until the user issues a command.
-- Requires the separate TCP plugin in the sibling TCP/ folder.

local TCP = dofile("../TCP/client.lua")
-- Whitelisted getters are loaded once and reused for explicit inspection and
-- context correlation. No arbitrary function names can be invoked.
local INSPECTIONS = dofile("inspections.lua")
local INSPECTION_BY_NAME = {}
for _, entry in ipairs(INSPECTIONS) do INSPECTION_BY_NAME[entry[1]] = entry[2] end
local conn
local connected = false
local watched = {}
local observations = {}
local EVENT_LIMIT = 20
local MAX_EVENT_RECORD = 32768
local EVENT_NAMES = dofile("events.lua")
local all_observations = {}
local all_samples = 0
local MAX_ALL_SHAPES_PER_EVENT = 6
local MAX_ALL_EXAMPLES_PER_SHAPE = 2
local MAX_ALL_SAMPLES = 512
local context_enabled = false
local CONTEXT_PROBES_PER_EVENT = 12

local function info(message)
    print("[APIProbe] " .. message)
end

local function send_record(category, name, body)
    if not connected or not conn then
        return nil, "collector is not connected; use /apidocs connect"
    end
    local payload = category .. "\0" .. name .. "\0" .. body
    if #payload > 262144 then return nil, "record too large" end
    return conn:Send(tostring(#payload) .. ":" .. payload)
end

local function connect()
    if conn then conn:Disconnect() end
    connected = false
    local client, err = TCP.Connect("127.0.0.1", 54000, {
        onConnect = function()
            connected = true
            info("connected to local collector")
        end,
        onDisconnect = function(reason)
            connected = false
            info("disconnected: " .. tostring(reason))
        end,
        onError = function(reason)
            connected = false
            info("TCP error: " .. tostring(reason))
        end
    })
    conn = client
    if not client then info("connection failed: " .. tostring(err)) end
end

-- Bounded table inspection for documented event payloads. Inspect primitive
-- values, field names and nested tables without invoking arbitrary __tostring
-- methods or traversing userdata. Chat events bypass this function entirely.
local TABLE_PREVIEW_DEPTH = 3
local TABLE_PREVIEW_KEYS = 12
local TABLE_PREVIEW_NODES = 64
local TABLE_PREVIEW_BYTES = 2048
local TABLE_STRING_BYTES = 512

local function quote(value)
    local seen, nodes = {}, 0

    local function preview(v, depth)
        local kind = type(v)
        if kind == "string" then
            local shortened = string.sub(v, 1, TABLE_STRING_BYTES)
            local text = string.format("%q", shortened)
            if #v > TABLE_STRING_BYTES then
                text = text .. " [string truncated; bytes=" .. #v .. "]"
            else
                text = text .. " (bytes=" .. #v .. ")"
            end
            return text
        elseif kind == "number" or kind == "boolean" or kind == "nil" then
            return tostring(v)
        elseif kind ~= "table" then
            -- Do not call user-defined tostring on userdata or functions.
            return "<" .. kind .. ">"
        end
        if seen[v] then return "<cycle>" end
        if depth >= TABLE_PREVIEW_DEPTH or nodes >= TABLE_PREVIEW_NODES then
            return "table{...}"
        end
        seen[v] = true
        local entries, count, key, limited = {}, 0, nil, false
        while true do
            local next_key = next(v, key)  -- raw iteration, no __pairs hook
            if next_key == nil then break end
            key = next_key
            count = count + 1
            if count > TABLE_PREVIEW_KEYS or nodes >= TABLE_PREVIEW_NODES then
                limited = true
                break
            end
            nodes = nodes + 1
            local key_type = type(key)
            if key_type == "string" or key_type == "number"
                    or key_type == "boolean" then
                local key_text
                if key_type == "string" then
                    local short_key = string.sub(key, 1, 128)
                    key_text = "[" .. string.format("%q", short_key) .. "]"
                    if #key > 128 then key_text = key_text .. "[key truncated]" end
                else
                    key_text = "[" .. tostring(key) .. "]"
                end
                local child = rawget(v, key)
                entries[#entries + 1] = {
                    key = key_text,
                    value = preview(child, depth + 1),
                }
            end
        end
        seen[v] = nil
        table.sort(entries, function(a, b) return a.key < b.key end)
        local parts = {}
        for _, entry in ipairs(entries) do
            parts[#parts + 1] = entry.key .. "=" .. entry.value
        end
        if limited then parts[#parts + 1] = "..." end
        return "table{" .. table.concat(parts, ", ") .. "}"
    end

    local ok, text = pcall(preview, value, 0)
    if not ok then return "<preview error>" end
    if #text > TABLE_PREVIEW_BYTES then
        return string.sub(text, 1, TABLE_PREVIEW_BYTES)
            .. "...[preview truncated]"
    end
    return text
end

-- Context is opt-in and only samples explicit read-only, no-argument
-- getters associated with selected event names. The snapshot is taken while
-- handling the callback; its timing relative to the game's state update is
-- not guaranteed. Strings are type-only: never collect target/player names.
local CONTEXT_RULES = {
    SECTOR_CHANGED = {"GetCurrentSectorid", "GetCurrentSystemid", "PlayerInStation"},
    SECTOR_LOADED = {"GetCurrentSectorid", "GetCurrentSystemid"},
    ENTERING_STATION = {"PlayerInStation", "GetCurrentStationID"},
    ENTERED_STATION = {"PlayerInStation", "GetCurrentStationID", "GetCurrentSectorid"},
    LEAVING_STATION = {"PlayerInStation", "GetCurrentStationID"},
    SHOW_STATION = {"PlayerInStation", "GetCurrentStationID"},
    TARGET_CHANGED = {"GetTargetInfo", "GetTargetDistance"},
    TARGET_HEALTH_UPDATE = {"GetTargetInfo", "GetTargetDistance"},
    TARGET_SCANNED = {"GetTargetInfo", "GetTargetDistance"},
    SHIP_CHANGED = {"GetActiveShipName", "HasActiveShip", "GetActiveShipHealth"},
    SHIP_UPDATED = {"GetActiveShipName", "HasActiveShip"},
    SHIP_SPAWNED = {"HasActiveShip", "GetActiveShipHealth"},
    PLAYER_GOT_HIT = {"GetCurrentSectorid", "GetActiveShipHealth"},
    PLAYER_DIED = {"GetCurrentSectorid", "PlayerInStation", "HasActiveShip"},
    STORM_STARTED = {"IsStormPresent", "GetCurrentSectorid"},
    STORM_STOPPED = {"IsStormPresent", "GetCurrentSectorid"},
    MISSIONLIST_UPDATED = {"PlayerInStation", "GetCurrentStationID"},
    NAVROUTE_CHANGED = {"GetCurrentSectorid", "GetCurrentSystemid"},
    NAVROUTE_ADD = {"GetCurrentSectorid", "GetCurrentSystemid"},
    CINEMATIC_START = {"PlayerInStation", "GetCurrentSectorid"},
}
local function context_returns(...)
    local n = select("#", ...)
    local values = {}
    for i = 1, math.min(n, 10) do
        local v = select(i, ...)
        local kind = type(v)
        if kind == "number" or kind == "boolean" then
            values[#values + 1] = kind .. ":" .. tostring(v)
        else
            -- Type only for strings, tables and userdata. No private names.
            values[#values + 1] = kind
        end
    end
    if n > 10 then values[#values + 1] = "..." end
    return n .. "[" .. table.concat(values, ",") .. "]"
end

local function event_context(event)
    if not context_enabled then return nil end
    local names = CONTEXT_RULES[event]
    if not names then return nil end
    local lines = {"context=callback-time-approved-getters-v1"}
    for _, name in ipairs(names) do
        local closure = INSPECTION_BY_NAME[name]
        if closure then
            local ok, value = pcall(function()
                return context_returns(closure())
            end)
            lines[#lines + 1] = "context." .. name .. "="
                .. (ok and value or "error")
        end
    end
    return table.concat(lines, "\n")
end

-- /apidocs watch all discovers signatures, bounded table shapes and a few
-- different values for each shape. Unlike the old type-only deduplication,
-- a new field or value can produce a new example without a focused watch.
-- Chat-related arguments are recorded ONLY by type, never by value/fields.
local function is_chat_event(name)
    return string.match(name, "^CHAT_")
        or string.match(name, "^ACTIVATE_CHAT_")
        or name == "COMMAND" or name == "EMOTE_ENTERED"
end

-- Shape fingerprint only: key names and nested types, not changing values.
-- It is bounded separately from the more detailed quote() preview.
local function event_shape(value)
    local seen, nodes = {}, 0
    local function walk(v, depth)
        local kind = type(v)
        if kind ~= "table" then return kind end
        if seen[v] then return "cycle" end
        if depth >= 3 or nodes >= 64 then return "table{...}" end
        seen[v] = true
        local fields, key, count, truncated = {}, nil, 0, false
        while true do
            local next_key = next(v, key)
            if next_key == nil then break end
            key = next_key
            count = count + 1
            if count > 12 or nodes >= 64 then
                truncated = true
                break
            end
            nodes = nodes + 1
            local key_kind = type(key)
            if key_kind == "string" or key_kind == "number"
                    or key_kind == "boolean" then
                local label
                if key_kind == "string" then
                    label = string.format("%q", string.sub(key, 1, 64))
                else
                    label = tostring(key)
                end
                fields[#fields + 1] = label .. ":" .. walk(rawget(v, key), depth + 1)
            end
        end
        seen[v] = nil
        if truncated then fields[#fields + 1] = "..." end
        table.sort(fields)
        return "table{" .. table.concat(fields, ",") .. "}"
    end
    local ok, text = pcall(walk, value, 0)
    if not ok then return "table{<unreadable>}" end
    if #text > 512 then return string.sub(text, 1, 512) .. "..." end
    return text
end

local function record_all(event, ...)
    local record = all_observations[event]
    if not record then
        record = {count = 0, samples = {}, shapes = {}, shape_count = 0,
                  context_probes = 0}
        all_observations[event] = record
    end
    record.count = record.count + 1
    if all_samples >= MAX_ALL_SAMPLES then return end

    local n = select("#", ...)
    local types, shapes, lines = {}, {}, {"event=" .. event, "arguments=" .. n}
    local chat = is_chat_event(event)
    for i = 1, math.min(n, 16) do
        local value = select(i, ...)
        local kind = type(value)
        types[#types + 1] = kind
        -- Never inspect chat-related table keys or contents.
        shapes[#shapes + 1] = (chat and kind or event_shape(value))
    end
    local signature = n .. ":" .. table.concat(types, ",")
    local shape = table.concat(shapes, ";")
    if chat then shape = "redacted" end
    local key = signature .. "|" .. shape
    local group = record.shapes[key]
    if not group then
        if record.shape_count >= MAX_ALL_SHAPES_PER_EVENT then return end
        group = {values = {}, count = 0}
        record.shapes[key] = group
        record.shape_count = record.shape_count + 1
    end
    if group.count >= MAX_ALL_EXAMPLES_PER_SHAPE then return end

    for i = 1, math.min(n, 16) do
        local value = select(i, ...)
        local line = "arg" .. i .. " type=" .. type(value)
        if not chat then
            line = line .. " value=" .. string.sub(quote(value), 1, 1024)
        end
        lines[#lines + 1] = line
    end
    if n > 16 then lines[#lines + 1] = "remaining_arguments=" .. (n - 16) end
    local body = table.concat(lines, "\n")
    if #body > 4096 then body = string.sub(body, 1, 4096) .. "\n[truncated]" end
    -- Context is sampled only for selected events and up to a small fixed
    -- number of times. Never probe chat-related callbacks.
    if not chat and context_enabled
            and record.context_probes < CONTEXT_PROBES_PER_EVENT then
        if CONTEXT_RULES[event] then
            record.context_probes = record.context_probes + 1
            local state = event_context(event)
            if state then body = body .. "\n" .. state end
        end
    end
    -- Different callback-time state can yield another example even if the
    -- event's own arguments are identical (still at most 2 per shape).
    if group.values[body] then return end
    group.values[body] = true
    group.count = group.count + 1
    record.samples[#record.samples + 1] = {
        signature = signature, shape = shape, body = body,
    }
    all_samples = all_samples + 1
end
local function flush_all()
    if not connected then
        info("connect first to flush all-event observations")
        return false
    end
    local records, observed = {}, 0
    for name, observation in pairs(all_observations) do
        if observation.count > 0 then observed = observed + 1 end
        for _, sample in ipairs(observation.samples) do
            records[#records + 1] = {
                name = name,
                signature = sample.signature,
                text = "signature=" .. sample.signature .. "\n"
                    .. "occurrences=" .. observation.count .. "\n"
                    .. "shape=" .. sample.shape .. "\n"
                    .. sample.body .. "\n",
            }
        end
    end
    if #records == 0 then
        info("no new all-event examples to flush")
        return true
    end
    table.sort(records, function(a, b)
        if a.name == b.name then
            if a.signature == b.signature then
                return a.text < b.text
            end
            return a.signature < b.signature
        end
        return a.name < b.name
    end)

    -- A few snapshots rather than potentially thousands of individual files.
    local part, chunk, bytes = 0, {}, 0
    local function send_chunk()
        if #chunk == 0 then return true end
        local header = {
            "format=api-event-watch-v3",
            "source=historical-event-candidates",
            "candidate_count=" .. #EVENT_NAMES,
            "observed_events=" .. observed,
            "part=" .. (part + 1),
        }
        local body = table.concat(header, "\n") .. "\n"
            .. table.concat(chunk, "\n---\n") .. "\n"
        local ok, err = send_record("snapshot", "event-watch", body)
        if not ok then return nil, err end
        part = part + 1
        chunk, bytes = {}, 0
        return true
    end
    for _, record in ipairs(records) do
        if bytes + #record.text > 24000 then
            local ok, err = send_chunk()
            if not ok then
                info("event flush failed: " .. tostring(err))
                return false
            end
        end
        chunk[#chunk + 1] = record.text
        bytes = bytes + #record.text
    end
    local ok, err = send_chunk()
    if not ok then
        info("event flush failed: " .. tostring(err))
        return false
    end
    -- Keep signature history to avoid duplicate reports on subsequent flushes.
    for _, observation in pairs(all_observations) do observation.samples = {} end
    info("queued " .. #records .. " event examples in "
        .. part .. " snapshot records (" .. observed .. " observed events)")
    return true
end

local observer = {}
function observer:OnEvent(event, ...)
    local mode = watched[event]
    if not mode then return end
    if mode == "all" then
        record_all(event, ...)
        return
    end
    local count = observations[event] or 0
    if count >= EVENT_LIMIT then return end
    observations[event] = count + 1

    local n = select("#", ...)
    local lines = {"event=" .. event, "arguments=" .. n}
    local chat = is_chat_event(event)
    -- Chat payloads are type-only. Other events keep bounded examples.
    for index = 1, math.min(n, 16) do
        local value = select(index, ...)
        local line = "arg" .. index .. " type=" .. type(value)
        if not chat then line = line .. " value=" .. quote(value) end
        lines[#lines + 1] = line
    end
    if n > 16 then lines[#lines + 1] = "remaining_arguments=" .. (n - 16) end
    local body = table.concat(lines, "\n") .. "\n"
    if #body > MAX_EVENT_RECORD then
        body = string.sub(body, 1, MAX_EVENT_RECORD)
            .. "\n[truncated]\n"
    end
    local ok, err = send_record("event", event, body)
    if not ok then
        -- Stop watching if the connection cannot accept more observations.
        info("event capture stopped: " .. tostring(err))
        local names = {}
        for name in pairs(watched) do names[#names + 1] = name end
        for _, name in ipairs(names) do
            UnregisterEvent(observer, name)
            watched[name] = nil
        end
    end
end

local function watch(name)
    if not connected then info("connect first with /apidocs connect"); return end
    if type(name) ~= "string" or not string.match(name, "^[A-Za-z_][A-Za-z0-9_]*$") then
        info("event name must contain only letters, digits, and underscores")
        return
    end
    if watched[name] == "all" then
        watched[name] = "detail"
        observations[name] = 0
        info("switched " .. name .. " to detailed capture")
        return
    end
    if watched[name] then info("already watching " .. name); return end
    local ok, err = pcall(RegisterEvent, observer, name)
    if not ok then info("unable to watch " .. name .. ": " .. tostring(err)); return end
    watched[name] = "detail"
    observations[name] = 0
    info("watching " .. name .. " (maximum " .. EVENT_LIMIT .. " observations)")
end

local function unwatch(name)
    if watched[name] then
        UnregisterEvent(observer, name)
        watched[name] = nil
        info("stopped watching " .. name)
    else
        info("not watching " .. tostring(name))
    end
end


local function watch_all()
    if not connected then
        info("connect first with /apidocs connect")
        return
    end
    local registered, failed = 0, 0
    for _, name in ipairs(EVENT_NAMES) do
        if not watched[name] then
            local ok = pcall(RegisterEvent, observer, name)
            if ok then
                watched[name] = "all"
                registered = registered + 1
            else
                failed = failed + 1
            end
        end
    end
    info("watching all " .. #EVENT_NAMES .. " historical event names ("
        .. registered .. " added, " .. failed .. " rejected); "
        .. "automatically samples shapes and values, buffered until flush/stop")
end

local function unwatch_all()
    local count = 0
    for name, mode in pairs(watched) do
        if mode == "all" then
            pcall(UnregisterEvent, observer, name)
            watched[name] = nil
            count = count + 1
        end
    end
    info("stopped " .. count .. " broad event watches")
end

local function stop()
    -- Keep buffered observations if a collector failure prevents flushing.
    local flush_ok = true
    if connected then
        flush_ok = flush_all()
    else
        for _, observation in pairs(all_observations) do
            if #observation.samples > 0 then flush_ok = false; break end
        end
    end
    if not flush_ok then
        info("stop aborted: buffered event examples remain; reconnect and flush")
        return
    end
    local names = {}
    for name in pairs(watched) do names[#names + 1] = name end
    for _, name in ipairs(names) do unwatch(name) end
    if conn then conn:Disconnect(); conn = nil end
    connected = false
    -- A later /apidocs watch all is a NEW session. Do not let the previous
    -- session's per-shape quotas suppress examples of changed game state.
    all_observations = {}
    all_samples = 0
    info("stopped")
end

-- Candidate closures are generated, so no _G/getfenv lookup is needed.
-- Only reads their types; never calls candidate functions.
local CANDIDATES = dofile("candidates.lua")

local function scan()
    if not connected then info("connect first with /apidocs connect"); return end
    local rows, found, inaccessible = {}, 0, 0
    for _, candidate in ipairs(CANDIDATES) do
        local ok, value = pcall(candidate[2])
        local status
        if ok then
            status = type(value)
            if status == "function" then found = found + 1 end
        else
            status = "inaccessible"
            inaccessible = inaccessible + 1
        end
        rows[#rows + 1] = candidate[1] .. "\t" .. status
    end
    table.sort(rows)

    -- Chunk larger inventories into bounded records on the TCP connection.
    local records, chunk = 0, {}
    local function send_chunk()
        if #chunk == 0 then return true end
        local lines = {
            "format=api-probe-v1",
            "source=generated-candidates",
            "candidate_count=" .. #CANDIDATES,
            "part=" .. (records + 1),
            "name\ttype_or_status",
        }
        for _, row in ipairs(chunk) do lines[#lines + 1] = row end
        local ok, err = send_record(
            "snapshot", "functions", table.concat(lines, "\n") .. "\n"
        )
        if not ok then return nil, err end
        records = records + 1
        chunk = {}
        return true
    end

    for _, row in ipairs(rows) do
        chunk[#chunk + 1] = row
        if #chunk >= 150 then
            local ok, err = send_chunk()
            if not ok then info("scan failed: " .. tostring(err)); return end
        end
    end
    local ok, err = send_chunk()
    if not ok then info("scan failed: " .. tostring(err)); return end
    info("checked " .. #CANDIDATES .. " candidates; found " .. found
        .. " functions; " .. inaccessible .. " inaccessible; "
        .. records .. " snapshots queued")
end


-- Return-value observations. String contents from approved state getters are
-- recorded (bounded to 1024 bytes); tables/userdata are never traversed.
local MAX_INSPECT_RETURNS = 24
local function summarize_returns(...)
    local count = select("#", ...)
    local lines = {"returns=" .. count}
    for i = 1, math.min(count, MAX_INSPECT_RETURNS) do
        local value = select(i, ...)
        local kind = type(value)
        local line = "return" .. i .. " type=" .. kind
        if kind == "string" then
            -- This allowlist contains state getters, not chat-log readers.
            -- Preserve the text for documentation, with a per-value bound.
            local text = string.sub(value, 1, 1024)
            line = line .. " value=" .. string.format("%q", text)
                .. " bytes=" .. #value
            if #value > 1024 then line = line .. " truncated=true" end
        elseif kind == "number" or kind == "boolean" then
            line = line .. " value=" .. tostring(value)
        end
        lines[#lines + 1] = line
    end
    if count > MAX_INSPECT_RETURNS then
        lines[#lines + 1] = "remaining_returns=" .. (count - MAX_INSPECT_RETURNS)
    end
    return table.concat(lines, "\n")
end

local function inspect_one(entry)
    -- The closure returns the getter's actual multiple return values.
    local ok, result = pcall(function()
        return summarize_returns(entry[2]())
    end)
    local lines = {
        "format=api-inspect-v1",
        "source=approved-no-arg",
        "function=" .. entry[1],
        "result=" .. (ok and "ok" or "error"),
    }
    if ok then
        lines[#lines + 1] = result
    else
        -- Error text may contain newlines; quote and bound it.
        lines[#lines + 1] = "error="
            .. string.format("%q", string.sub(tostring(result), 1, 240))
    end
    local sent, err = send_record(
        "function", entry[1], table.concat(lines, "\n") .. "\n"
    )
    if not sent then return nil, err end
    return true, ok
end

local function inspect(name)
    if not name or name == "list" then
        local names = {}
        for _, entry in ipairs(INSPECTIONS) do names[#names + 1] = entry[1] end
        table.sort(names)
        info("approved getters: " .. table.concat(names, ", "))
        info("use /apidocs inspect NAME or /apidocs inspect all")
        return
    end
    if not connected then
        info("connect first with /apidocs connect")
        return
    end
    if name == "all" then
        local successes, errors = 0, 0
        for _, entry in ipairs(INSPECTIONS) do
            local sent, result = inspect_one(entry)
            if not sent then
                info("inspection stopped: " .. tostring(result))
                return
            end
            if result then successes = successes + 1
            else errors = errors + 1 end
        end
        info("queued " .. (successes + errors) .. " inspection records ("
            .. successes .. " calls succeeded, " .. errors .. " raised errors)")
        return
    end
    for _, entry in ipairs(INSPECTIONS) do
        if entry[1] == name then
            local sent, result = inspect_one(entry)
            if not sent then info("inspection failed: " .. tostring(result))
            else info(name .. " observation queued ("
                .. (result and "ok" or "call error") .. ")") end
            return
        end
    end
    info("not approved for inspection: " .. tostring(name))
    info("use /apidocs inspect list")
end

local function command(_, args)
    local action = args and args[1] and string.lower(args[1]) or "help"
    local name = args and args[2]
    if action == "connect" then
        connect()
    elseif action == "test" then
        local ok, err = send_record("note", "connection_test", "First line\nSecond line\n")
        info(ok and "test record queued" or ("test failed: " .. tostring(err)))
    elseif action == "scan" then
        scan()
    elseif action == "inspect" then
        inspect(name)
    elseif action == "watch" then
        if name == "all" then watch_all() else watch(name) end
    elseif action == "unwatch" then
        if name == "all" then
            if connected then flush_all() end
            unwatch_all()
        else
            unwatch(name)
        end
    elseif action == "flush" then
        flush_all()
    elseif action == "context" then
        if name == "on" then
            context_enabled = true
            info("context correlation on (bounded approved getters for selected events)")
        elseif name == "off" then
            context_enabled = false
            info("context correlation off")
        else
            info("context is " .. (context_enabled and "on" or "off")
                .. "; use /apidocs context on or off")
        end
    elseif action == "status" then
        local n = 0
        for _ in pairs(watched) do n = n + 1 end
        info((connected and "connected" or "not connected")
            .. "; watching " .. n .. " events"
            .. "; context " .. (context_enabled and "on" or "off"))
    elseif action == "stop" then
        stop()
    else
        info("/apidocs connect | test | scan | inspect [list|NAME|all] | watch [EVENT|all] | unwatch [EVENT|all] | context [on|off] | flush | status | stop")
    end
end

RegisterUserCommand("apidocs", command)
info("loaded; /apidocs connect to begin")
