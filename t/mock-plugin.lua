-- Run from repository root: texlua t/mock-plugin.lua
local real_dofile = dofile
local commands = {}
local watched = {}
local frames = {}
local last_connection

function RegisterUserCommand(name, callback) commands[name] = callback end
function RegisterEvent(handler, name) watched[name] = handler end
function UnregisterEvent(handler, name)
    assert(watched[name] == handler)
    watched[name] = nil
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

dofile = function(path)
    if path == "../TCP/client.lua" then return TCP end
    return real_dofile(path)
end

-- Emulate the VO strict-global proxy: unknown globals raise an error.
-- In particular, VO does not expose _G or getfenv.
local base_globals = _G
local strict_environment = {}
setmetatable(strict_environment, {
    __index = function(_, key)
        local value = key ~= "_G" and key ~= "getfenv" and base_globals[key]
        if value == nil or value == false then
            error("attempt to read from undeclared variable " .. key)
        end
        return value
    end,
})
local chunk
if type(setfenv) == "function" then
    chunk = assert(loadfile("plugin/APIProbe/main.lua"))
    setfenv(chunk, strict_environment)
else
    chunk = assert(loadfile("plugin/APIProbe/main.lua", "t", strict_environment))
end
chunk()
dofile = real_dofile
assert(type(commands.apidocs) == "function", "command was registered")

local function run(...)
    return commands.apidocs(nil, {...})
end
local function decode(wire)
    local bytes, payload = string.match(wire, "^(%d+):(.*)$")
    assert(tonumber(bytes) == #payload, "framing length mismatch")
    local category, name, body = string.match(payload, "^([^%z]+)%z([^%z]+)%z(.*)$")
    assert(category and name and body, "record layout mismatch")
    return category, name, body
end

run("test")
assert(#frames == 0, "should not send without connection")
run("connect")
assert(last_connection ~= nil, "no connection started")
last_connection.options.onConnect()
run("test")
assert(#frames == 1)
local category, name, body = decode(frames[1])
assert(category == "note" and name == "connection_test")
assert(body == "First line\nSecond line\n", "multiline payload changed")

run("watch", "SECTOR_LOADED")
assert(watched.SECTOR_LOADED)
watched.SECTOR_LOADED:OnEvent("SECTOR_LOADED", "one\ntwo", 3, {x = true})
category, name, body = decode(frames[2])
assert(category == "event" and name == "SECTOR_LOADED")
assert(string.find(body, "arg1 type=string", 1, true))
assert(string.find(body, "arg2 type=number value=3", 1, true))
run("unwatch", "SECTOR_LOADED")
assert(watched.SECTOR_LOADED == nil)

run("scan")
assert(#frames > 2)
category, name, body = decode(frames[3])
assert(category == "snapshot" and name == "functions")
assert(string.find(body, "format=api-probe-v1", 1, true))
assert(string.find(body, "source=curated-candidates", 1, true))
assert(string.find(body, "RegisterEvent\tfunction", 1, true))
assert(string.find(body, "GetCurrentSectorid\tinaccessible", 1, true))
run("stop")
assert(next(watched) == nil)
print("PASS: Lua APIProbe mock protocol, scan, watch, and stop")
