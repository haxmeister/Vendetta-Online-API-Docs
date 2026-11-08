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
    local conn = {}
    function conn:Send(bytes)
        frames[#frames + 1] = bytes
        return true
    end
    function conn:Disconnect()
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
assert(string.find(body, "return1 type=string bytes=", 1, true))
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

run("stop")
assert(next(watched) == nil)
print("PASS: APIProbe strict-global scan, allowlisted getter inspection, and events")
