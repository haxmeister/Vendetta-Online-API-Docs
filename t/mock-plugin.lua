-- Run from repository root: texlua t/mock-plugin.lua
local real_dofile = dofile
local commands, watched, frames = {}, {}, {}
local last_connection

function RegisterUserCommand(name, callback) commands[name] = callback end
function RegisterEvent(handler, name) watched[name] = handler end
function UnregisterEvent(handler, name)
    assert(watched[name] == handler)
    watched[name] = nil
end
local calls = {sector = 0, health = 0, target = 0, distance = 0}
function GetCurrentSectorid()
    calls.sector = calls.sector + 1
    return 42
end
function GetActiveShipHealth()
    calls.health = calls.health + 1
    return 0.8, nil, 75
end
function GetTargetInfo()
    calls.target = calls.target + 1
    return "private player name\nwith newline", 0.5, 100, nil
end
function GetTargetDistance()
    calls.distance = calls.distance + 1
    error("simulated missing target")
end

local TCP = {}
function TCP.Connect(host, port, options)
    assert(host == "127.0.0.1" and port == 54000)
    local conn = {pendingBytes = 0, disconnects = 0}
    function conn:Send(bytes)
        frames[#frames + 1] = bytes
        return true
    end
    function conn:Disconnect()
        self.disconnects = self.disconnects + 1
        options.onDisconnect("test disconnect")
    end
    last_connection = {client = conn, options = options}
    return conn
end

-- Simulate the VO strict-global environment for the plugin and probes.
local normal_globals = _G
local env = {}
setmetatable(env, {
    __index = function(_, name)
        if name == "_G" or name == "getfenv" or normal_globals[name] == nil then
            error("attempt to read from undeclared variable " .. name)
        end
        return normal_globals[name]
    end,
})
local function load_in_env(path)
    local chunk
    if type(setfenv) == "function" then
        chunk = assert(loadfile(path))
        setfenv(chunk, env)
    else
        chunk = assert(loadfile(path, "t", env))
    end
    return chunk()
end

dofile = function(path)
    if path == "../TCP/client.lua" then return TCP end
    if path == "candidates.lua" then
        return load_in_env("plugin/APIProbe/candidates.lua")
    end
    if path == "inspections.lua" then
        return load_in_env("plugin/APIProbe/inspections.lua")
    end
    if path == "events.lua" then
        return load_in_env("plugin/APIProbe/events.lua")
    end
    return real_dofile(path)
end
load_in_env("plugin/APIProbe/main.lua")
dofile = real_dofile
assert(type(commands.apidocs) == "function", "command not registered")

local function run(...)
    return commands.apidocs(nil, {...})
end
local function decode(wire)
    local size, payload = string.match(wire, "^(%d+):(.*)$")
    assert(tonumber(size) == #payload, "framing length mismatch")
    local category, name, body = string.match(payload, "^([^%z]+)%z([^%z]+)%z(.*)$")
    assert(category and name and body, "record layout mismatch")
    return category, name, body
end

run("inspect", "list")
run("inspect", "GetCurrentSectorid")
assert(calls.sector == 0, "inspection must not call getters without connection")
run("test")
assert(#frames == 0, "should not send without connection")
run("connect")
assert(last_connection, "connection not started")
last_connection.options.onConnect()
run("test")
assert(#frames == 1)
local category, name, body = decode(frames[1])
assert(category == "note" and name == "connection_test")
assert(body == "First line\nSecond line\n", "multiline body changed")

run("watch", "SECTOR_LOADED")
assert(watched.SECTOR_LOADED)
watched.SECTOR_LOADED:OnEvent("SECTOR_LOADED", "one\ntwo", 3, {x = true})
category, name, body = decode(frames[2])
assert(category == "event" and name == "SECTOR_LOADED")
assert(string.find(body, "arg1 type=string", 1, true))
assert(string.find(body, "arg2 type=number value=3", 1, true))
run("unwatch", "SECTOR_LOADED")
assert(watched.SECTOR_LOADED == nil)

local expected = #load_in_env("plugin/APIProbe/candidates.lua")
run("scan")
assert(#frames == 2 + math.ceil(expected / 150), "unexpected snapshot count")
local rows, statuses = 0, {}
for index = 3, #frames do
    category, name, body = decode(frames[index])
    assert(category == "snapshot" and name == "functions")
    assert(string.find(body, "format=api-probe-v1", 1, true))
    assert(string.find(body, "source=generated-candidates", 1, true))
    assert(string.find(body, "candidate_count=" .. expected, 1, true))
    assert(string.find(body, "part=" .. (index - 2), 1, true))
    for line in string.gmatch(body, "[^\n]+") do
        local id, status = string.match(line, "^([A-Za-z_][A-Za-z0-9_]*)\t([a-z]+)$")
        if id then
            assert(statuses[id] == nil, "duplicate: " .. id)
            statuses[id] = status
            rows = rows + 1
        end
    end
end
assert(rows == expected, "lost function candidates")
assert(statuses.RegisterEvent == "function")
assert(statuses.GetCurrentSectorid == "function")
assert(statuses.GetCharInfo == "inaccessible")
-- The inspector must run only explicitly allowlisted getters.
local approved = load_in_env("plugin/APIProbe/inspections.lua")
local before_inspect = #frames
run("inspect", "RunTutorial")
run("inspect", "GetMoney")
assert(#frames == before_inspect, "unapproved calls must not capture")
assert(calls.sector == 0, "scan must not invoke getters")

run("inspect", "GetCurrentSectorid")
assert(calls.sector == 1)
category, name, body = decode(frames[#frames])
assert(category == "function" and name == "GetCurrentSectorid")
assert(string.find(body, "format=api-inspect-v1", 1, true))
assert(string.find(body, "source=approved-no-arg", 1, true))
assert(string.find(body, "result=ok", 1, true))
assert(string.find(body, "returns=1", 1, true))
assert(string.find(body, "return1 type=number value=42", 1, true))

run("inspect", "GetActiveShipHealth")
assert(calls.health == 1)
category, name, body = decode(frames[#frames])
assert(category == "function" and name == "GetActiveShipHealth")
assert(string.find(body, "returns=3", 1, true))
assert(string.find(body, "return2 type=nil", 1, true))
assert(string.find(body, "return3 type=number value=75", 1, true))

run("inspect", "GetTargetInfo")
assert(calls.target == 1)
category, name, body = decode(frames[#frames])
assert(string.find(body, "returns=4", 1, true))
assert(string.find(body, "return1 type=string value=", 1, true),
    "capture text from approved getter")
assert(string.find(body, "private player name", 1, true),
    "preserve getter string contents for documentation")
assert(string.find(body, "bytes=", 1, true),
    "preserve original byte length")
assert(string.find(body, "return4 type=nil", 1, true))

run("inspect", "GetTargetDistance")
assert(calls.distance == 1)
category, name, body = decode(frames[#frames])
assert(string.find(body, "result=error", 1, true))
assert(string.find(body, "simulated missing target", 1, true))

local before_all = #frames
run("inspect", "all")
assert(#frames == before_all + #approved, "all must inspect only approved getters")
assert(calls.sector == 2 and calls.health == 2
    and calls.target == 2 and calls.distance == 2)
for i = before_all + 1, #frames do
    category, name, body = decode(frames[i])
    assert(category == "function" and type(name) == "string")
    assert(string.find(body, "source=approved-no-arg", 1, true))
end

-- Broad watch: 214 unique historical event names, few aggregated files.
local known_events = load_in_env("plugin/APIProbe/events.lua")
assert(#known_events == 214, "unexpected historical event count")
run("context", "on")
run("watch", "all")
local registered = 0
for _, event in ipairs(known_events) do
    assert(watched[event], "missing broad event watch for " .. event)
    registered = registered + 1
end
assert(registered == 214)
local baseline = #frames
watched.TARGET_CHANGED:OnEvent("TARGET_CHANGED")
watched.TARGET_CHANGED:OnEvent("TARGET_CHANGED", "Asteroid", 12)
watched.TARGET_CHANGED:OnEvent("TARGET_CHANGED", "Another target", 13)
watched.SECTOR_CHANGED:OnEvent("SECTOR_CHANGED", 5597)
watched.SECTOR_CHANGED:OnEvent("SECTOR_CHANGED", 5598)
watched.CHAT_MSG_PRIVATE:OnEvent("CHAT_MSG_PRIVATE", "private conversation")
watched.ACTIVATE_CHAT_PRIVATE:OnEvent("ACTIVATE_CHAT_PRIVATE", "private recipient")
local route = {
    [1] = 5570,
    destination = "Sedina",
    nested = {length = 2, valid = true},
}
route.self = route -- ensure cyclic tables cannot crash inspection
watched.NAVROUTE_CHANGED:OnEvent("NAVROUTE_CHANGED", route)
route.destination = "Bractus"
watched.NAVROUTE_CHANGED:OnEvent("NAVROUTE_CHANGED", route)
route.destination = "Dau"
watched.NAVROUTE_CHANGED:OnEvent("NAVROUTE_CHANGED", route)
-- New field: this must be captured even after value-example quota fills.
route.destination = "Sedina"
route.comment = "Different shape"
watched.NAVROUTE_CHANGED:OnEvent("NAVROUTE_CHANGED", route)
route.comment = nil
route.destination = "Sedina"
watched.CHAT_MSG_PRIVATE:OnEvent("CHAT_MSG_PRIVATE", {
    message = "private table message", speaker = "private table speaker",
})
for i = 1, 30 do
    watched.HUD_UPDATE:OnEvent("HUD_UPDATE", i)
end
assert(#frames == baseline, "broad watch must buffer observations")
run("flush")
assert(#frames > baseline, "flush must generate event summary")
local whole = ""
for i = baseline + 1, #frames do
    category, name, body = decode(frames[i])
    assert(category == "snapshot" and name == "event-watch")
    assert(string.find(body, "format=api-event-watch-v3", 1, true))
    assert(string.find(body, "candidate_count=214", 1, true))
    whole = whole .. body
end
assert(string.find(whole, "event=TARGET_CHANGED", 1, true))
assert(string.find(whole, "event=SECTOR_CHANGED", 1, true))
assert(string.find(whole, "context=callback-time-approved-getters-v1", 1, true),
    "context is attached to selected events")
assert(string.find(whole, "context.GetCurrentSectorid=1[number:42]", 1, true),
    "callback-time context records allowlisted numeric getter values")
assert(string.find(whole, "context.GetTargetInfo=4[string,number:0.5,number:100,nil]", 1, true),
    "context preserves multiple return positions without exposing names")
assert(string.find(whole, "context.GetTargetDistance=error", 1, true),
    "context getter failures must not interrupt event capture")
assert(not string.find(whole, "private player name", 1, true),
    "context getter strings must not expose target names")
assert(string.find(whole, "occurrences=30", 1, true))
assert(string.find(whole, "Asteroid", 1, true), "non-chat samples retain values")
assert(string.find(whole, '["destination"]="Sedina"', 1, true),
    "non-chat table preview should record actual string values")
assert(string.find(whole, '["destination"]="Bractus"', 1, true),
    "second value with unchanged shape should be captured automatically")
assert(not string.find(whole, '["destination"]="Dau"', 1, true),
    "third value with unchanged shape should respect the per-shape cap")
assert(string.find(whole, '["comment"]="Different shape"', 1, true),
    "changed table fields should be captured automatically")
assert(string.find(whole, "shape=", 1, true),
    "snapshots must record table shape metadata")
local route_samples = select(2, string.gsub(whole, "event=NAVROUTE_CHANGED", ""))
assert(route_samples == 3, "expect 2 distinct values plus 1 changed table shape")
local speed_samples = select(2, string.gsub(whole, "event=HUD_UPDATE", ""))
assert(speed_samples == 2, "noisy numeric events must be capped per shape")
assert(string.find(whole, '["length"]=2', 1, true),
    "nested table preview should record numeric values")
assert(string.find(whole, '["valid"]=true', 1, true),
    "nested table preview should record booleans")
assert(string.find(whole, "<cycle>", 1, true),
    "cycles should be detected without recursion")
assert(string.find(whole, "event=CHAT_MSG_PRIVATE", 1, true))
assert(not string.find(whole, "private table message", 1, true),
    "chat table contents must never be inspected")
assert(not string.find(whole, "private table speaker", 1, true),
    "chat table player names must never be inspected")
assert(not string.find(whole, "private conversation", 1, true),
    "chat content must not be collected")
assert(not string.find(whole, "private recipient", 1, true),
    "chat activation must not expose recipient")
assert(not string.find(whole, "private table speaker", 1, true),
    "chat field names and scalar values must stay private")
local after_flush = #frames
run("flush")
assert(#frames == after_flush, "unchanged signatures should not be sent twice")
run("unwatch", "all")
assert(next(watched) == nil, "unwatch all should release broad watches")
run("context", "off")
run("watch", "CHAT_MSG_PRIVATE")
watched.CHAT_MSG_PRIVATE:OnEvent("CHAT_MSG_PRIVATE", "secret explicit chat")
category, name, body = decode(frames[#frames])
assert(category == "event" and name == "CHAT_MSG_PRIVATE")
assert(string.find(body, "arg1 type=string", 1, true))
assert(not string.find(body, "secret explicit chat", 1, true),
    "explicit chat capture must also be type-only")
run("unwatch", "CHAT_MSG_PRIVATE")

-- Focused watches should capture table fields per occurrence.
run("watch", "NAVROUTE_CHANGED")
watched.NAVROUTE_CHANGED:OnEvent("NAVROUTE_CHANGED", route)
category, name, body = decode(frames[#frames])
assert(category == "event" and name == "NAVROUTE_CHANGED")
assert(string.find(body, '["destination"]="Sedina"', 1, true))
assert(string.find(body, '["length"]=2', 1, true))
run("unwatch", "NAVROUTE_CHANGED")

run("stop")
assert(next(watched) == nil)

-- A second collection session should sample previously exhausted signatures.
-- Previously SECTOR_CHANGED used both of its per-shape example slots.
local before_second = #frames
run("connect")
last_connection.options.onConnect()
run("watch", "all")
watched.SECTOR_CHANGED:OnEvent("SECTOR_CHANGED", 5597)
run("flush")
assert(#frames > before_second, "new session must reset sample quotas")
local found_second = false
for i = before_second + 1, #frames do
    category, name, body = decode(frames[i])
    if name == "event-watch" and
        string.find(body, "event=SECTOR_CHANGED", 1, true) then
        found_second = true
    end
end
assert(found_second, "fresh watch-all session must capture earlier event forms")
run("stop")

-- TCP.Send can report success with bytes still queued for later writable
-- callbacks. A stop must not disconnect until those bytes have drained.
run("connect")
last_connection.options.onConnect()
run("watch", "all")
watched.SECTOR_CHANGED:OnEvent("SECTOR_CHANGED", 6000)
local pending_client = last_connection.client
pending_client.pendingBytes = 42
run("stop")
assert(next(watched) == nil, "stop should unregister callbacks immediately")
assert(pending_client.disconnects == 0, "stop must not drop queued TCP frames")
pending_client.pendingBytes = 0 -- simulate a later TCP writable callback
run("stop")
assert(pending_client.disconnects == 1, "stop should disconnect once queue drains")

-- The one-command session should connect, enable context and watch all.
local before_autopilot = #frames
run("start")
last_connection.options.onConnect()
assert(watched.SECTOR_CHANGED and watched.NAVROUTE_CHANGED,
    "start should install broad watches")
watched.SECTOR_CHANGED:OnEvent("SECTOR_CHANGED", 5597)
local conn_opts = last_connection.options
conn_opts.onMessage("APIDOCS|FLUSH")
assert(#frames > before_autopilot, "collector-requested flush must work")
category, name, body = decode(frames[#frames])
assert(category == "snapshot" and name == "event-watch")
assert(string.find(body, "context.GetCurrentSectorid=1[number:42]", 1, true),
    "start must enable approved callback-time context")

local before_remote = #frames
conn_opts.onMessage("APIDOCS|abcdef1234|INSPECT|all")
assert(#frames == before_remote + #approved,
    "remote inspection runs only approved getter allowlist")
conn_opts.onMessage("APIDOCS|abcdef1234|INSPECT|all")
assert(#frames == before_remote + #approved,
    "duplicate plan line must not run inspections twice")
conn_opts.onMessage("APIDOCS|abcdef1234|UNSAFE|loadstring")
assert(#frames == before_remote + #approved,
    "unknown remote control actions must not be executed")
conn_opts.onMessage("APIDOCS|abcdef1234|CONTEXT|off")
watched.SECTOR_CHANGED:OnEvent("SECTOR_CHANGED", 5600)
conn_opts.onMessage("APIDOCS|FLUSH")
category, name, body = decode(frames[#frames])
assert(string.find(body, "value=5600", 1, true))
assert(not string.find(body, "context.GetCurrentSectorid=", 1, true),
    "remote context off prevents subsequent getter snapshots")

run("finish")
assert(next(watched) == nil, "finish should unregister broad watches")

print("PASS: APIProbe strict-global scan, getters, context, and event capture")
