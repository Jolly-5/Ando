-- scripts/rovus_session_start.lua
--
-- Starts a QA/engineering session and records it in QA_SESSION + CURRENT_STATE.
-- Usage:
--   lua scripts/rovus_session_start.lua <sessionTag>

local args = {...}
local tag = args[1] or "session"

table.insert(args, 1, "")

local function readAll(path)
	local f = io.open(path, "r")
	if not f then return nil end
	local s = f:read("*a")
	f:close()
	return s
end

local function writeAll(path, content)
	local f, err = io.open(path, "w")
	if not f then
		io.stderr:write("Failed to write " .. path .. ": " .. tostring(err) .. "\n")
		os.exit(1)
	end
	f:write(content)
	f:close()
end

local root = "."
local qaPath = root .. "/Audit/Log/QA_SESSION.md"
local statePath = root .. "/Audit/Log/CURRENT_STATE.md"

local timestamp = os.date("%Y-%m-%dT%H:%M:%S%z")
local entry = "\n## " .. timestamp .. " - " .. tag .. "\nStatus: In Progress\nNext Action: (pending)\n"

-- Append to QA_SESSION.md (append-only intent).
do
	local f = io.open(qaPath, "a")
	if not f then
		io.stderr:write("QA_SESSION.md missing or not writable: " .. qaPath .. "\n")
		os.exit(1)
	end
	f:write(entry)
	f:close()
end

-- Update CURRENT_STATE.md with a minimal append (safe, readable change).
do
	local content = readAll(statePath) or "# CURRENT_STATE\n\n"
	content = content .. "\n\n[Session Start] " .. timestamp .. " - " .. tag .. "\n"
	writeAll(statePath, content)
end

print("ROVUS session started: " .. tag)

