-- scripts/rovus_audit_append.lua
--
-- Local helper to append audit log entries.
-- Usage:
--   lua scripts/rovus_audit_append.lua <logFile> <message...>

local args = {...}
if #args < 2 then
	io.write("Usage: lua scripts/rovus_audit_append.lua <logFile> <message...>\n")
	os.exit(1)
end

local logFile = args[1]
local message = table.concat(args, " ")

-- Basic sanitization: strip newlines to keep append-only logs readable.
message = message:gsub("[\r\n]+", " ")

local f, err = io.open(logFile, "a")
if not f then
	io.write("Failed to open log file: " .. tostring(err) .. "\n")
	os.exit(1)
end

local timestamp = os.date("%Y-%m-%dT%H:%M:%S%z")
f:write("[" .. timestamp .. "] " .. message .. "\n")
f:close()

