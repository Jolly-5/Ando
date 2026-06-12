-- scripts/rovus_verify_runtime.lua
-- Lightweight local verification helper.
-- This does not run Roblox; it just verifies files exist and prints guidance.

local function exists(p)
	local f = io.open(p, "r")
	if f then
		f:close()
		return true
	end
	return false
end

local required = {
	"src/shared/rovusTypes.lua",
	"src/shared/rovusUtil.lua",
	"src/shared/rovusEventBus.lua",
	"src/client/rovusClient.lua",
	"src/server/rovusServer.lua",
	"src/server/init.server.luau",
	"src/client/init.client.luau",
	"default.project.json",
	"Audit/Log/CURRENT_STATE.md",
}

local missing = {}
for _, p in ipairs(required) do
	if not exists(p) then
		table.insert(missing, p)
	end
end

if #missing > 0 then
	io.write("Missing required files:\n")
	for _, m in ipairs(missing) do
		io.write("- " .. m .. "\n")
	end
	os.exit(1)
end

print("ROVUS repo scaffolding looks present. Next: run `rojo build -o AndoWin.rbxlx` and verify in Roblox Studio.")

