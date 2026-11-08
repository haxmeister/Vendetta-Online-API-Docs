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
local MAX_SCAN_ROWS = 10000
local ROWS_PER_FRAME = 120

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

-- Candidates come from known plugin/API examples. Reading these names through
-- protected closures avoids _G/getfenv, which VO intentionally does not expose.
-- This list is not exhaustive: extend it as we import published API references.
-- A probe only reads a value; it never calls a candidate function.
local CANDIDATES = {
    {"RegisterEvent",             function() return RegisterEvent end},
    {"UnregisterEvent",           function() return UnregisterEvent end},
    {"ProcessEvent",              function() return ProcessEvent end},
    {"RegisterUserCommand",       function() return RegisterUserCommand end},
    {"ReloadInterface",          function() return ReloadInterface end},
    {"TCPSocket",                function() return TCPSocket end},
    {"GetCurrentSectorid",       function() return GetCurrentSectorid end},
    {"GetCurrentSystemid",       function() return GetCurrentSystemid end},
    {"GetCurrentStationid",      function() return GetCurrentStationid end},
    {"GetSectorName",            function() return GetSectorName end},
    {"GetPlayerName",            function() return GetPlayerName end},
    {"GetPlayerID",              function() return GetPlayerID end},
    {"GetCurrentCharId",         function() return GetCurrentCharId end},
    {"GetTargetInfo",            function() return GetTargetInfo end},
    {"PlayerInventoryPairs",     function() return PlayerInventoryPairs end},
    {"GetInventoryItemInfo",     function() return GetInventoryItemInfo end},
    {"GetInventoryItemName",     function() return GetInventoryItemName end},
    {"LoadSystemNotes",          function() return LoadSystemNotes end},
    {"SaveSystemNotes",          function() return SaveSystemNotes end},
    {"GetCharInfo",              function() return GetCharInfo end},
    {"iup",                      function() return iup end},
    {"rmlui",                    function() return rmlui end},
}

local function scan()
    if not connected then info("connect first with /apidocs connect"); return end
    local rows = {}
    local found, inaccessible = 0, 0
    for _, candidate in ipairs(CANDIDATES) do
        local ok, value = pcall(candidate[2])
        local status
        if ok then
            status = type(value)
            if status == "function" then found = found + 1 end
        else
            -- A missing name raises an error in VO's strict environment.
            -- It may also be blocked for other reasons; don't assume absent.
            status = "inaccessible"
            inaccessible = inaccessible + 1
        end
        rows[#rows + 1] = candidate[1] .. "\t" .. status
    end
    table.sort(rows)

    -- Keep the snapshot small and explicit about its limited coverage.
    local lines = {
        "format=api-probe-v1",
        "source=curated-candidates",
        "candidate_count=" .. #CANDIDATES,
        "name\ttype_or_status",
    }
    for _, row in ipairs(rows) do lines[#lines + 1] = row end
    local ok, err = send_record(
        "snapshot", "functions", table.concat(lines, "\n") .. "\n"
    )
    if not ok then info("scan failed: " .. tostring(err)); return end
    info("checked " .. #CANDIDATES .. " candidates; found " .. found
        .. " functions; " .. inaccessible .. " inaccessible; snapshot queued")
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
        info("/apidocs connect | test | scan | watch EVENT | unwatch EVENT | status | stop")
    end
end

RegisterUserCommand("apidocs", command)
info("loaded; /apidocs connect to begin")
