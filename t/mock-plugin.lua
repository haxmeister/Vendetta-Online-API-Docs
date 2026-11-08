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
function GetCurrentSectorid() return 42 end

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

run("scan")
assert(#frames > 2)
category, name, body = decode(frames[3])
assert(category == "snapshot" and name == "functions")
assert(string.find(body, "format=api-probe-v1", 1, true))
assert(string.find(body, "source=generated-candidates", 1, true))
assert(string.find(body, "candidate_count=28", 1, true))
assert(string.find(body, "RegisterEvent\tfunction", 1, true))
assert(string.find(body, "GetCurrentSectorid\tfunction", 1, true))
assert(string.find(body, "GetCharInfo\tinaccessible", 1, true))
run("stop")
assert(next(watched) == nil)
print("PASS: APIProbe strict-global mock and generated probes")
