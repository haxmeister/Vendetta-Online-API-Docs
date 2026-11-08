-- Vendetta Online API observation plugin.
-- Nothing is captured until the user issues a command.
-- Requires the separate TCP plugin in the sibling TCP/ folder.

local TCP = dofile("../TCP/client.lua")
local conn
local connected = false
local watched = {}
local observations = {}
local EVENT_LIMIT = 20
local MAX_EVENT_RECORD = 32768

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

local function quote(value)
    local kind = type(value)
    if kind == "string" then
        return string.format("%q", value) .. " (bytes=" .. #value .. ")"
    elseif kind == "number" or kind == "boolean" or kind == "nil" then
        return tostring(value)
    elseif kind == "table" then
        -- A shallow type preview; do not dump entire plugin or UI objects.
        local parts, n = {}, 0
        for key, entry in pairs(value) do
            n = n + 1
            if n > 12 then break end
            local keykind = type(key)
            if keykind == "string" or keykind == "number" then
                parts[#parts + 1] = string.format("%q", tostring(key))
                    .. ":" .. type(entry)
            end
        end
        table.sort(parts)
        return "table{" .. table.concat(parts, ", ")
            .. (n > 12 and ", ..." or "") .. "}"
    end
    -- Avoid calling arbitrary __tostring metamethods on userdata.
    return "<" .. kind .. ">"
end

local observer = {}
function observer:OnEvent(event, ...)
    if not watched[event] then return end
    local count = observations[event] or 0
    if count >= EVENT_LIMIT then return end
    observations[event] = count + 1

    local n = select("#", ...)
    local lines = {"event=" .. event, "arguments=" .. n}
    -- Only send the first 16 arguments and bound the total record size.
    for index = 1, math.min(n, 16) do
        local value = select(index, ...)
        lines[#lines + 1] = "arg" .. index .. " type=" .. type(value)
            .. " value=" .. quote(value)
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
    if watched[name] then info("already watching " .. name); return end
    local ok, err = pcall(RegisterEvent, observer, name)
    if not ok then info("unable to watch " .. name .. ": " .. tostring(err)); return end
    watched[name] = true
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

local function stop()
    local names = {}
    for name in pairs(watched) do names[#names + 1] = name end
    for _, name in ipairs(names) do unwatch(name) end
    if conn then conn:Disconnect(); conn = nil end
    connected = false
    info("stopped")
end

-- Candidate closures are generated, so no _G/getfenv lookup is needed.
-- Only reads their types; never calls candidate functions.
local CANDIDATES = dofile("candidates.lua")
-- Unlike generated name probes, these explicitly call only approved getters.
local INSPECTIONS = dofile("inspections.lua")

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
        watch(name)
    elseif action == "unwatch" then
        unwatch(name)
    elseif action == "status" then
        local n = 0
        for _ in pairs(watched) do n = n + 1 end
        info((connected and "connected" or "not connected")
            .. "; watching " .. n .. " events")
    elseif action == "stop" then
        stop()
    else
        info("/apidocs connect | test | scan | inspect [list|NAME|all] | watch EVENT | unwatch EVENT | status | stop")
    end
end

RegisterUserCommand("apidocs", command)
info("loaded; /apidocs connect to begin")
