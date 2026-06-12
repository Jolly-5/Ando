-- src/client/rovusClient.lua
-- Client-side bootstrap for ROVUS.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RovusEventBus = ReplicatedStorage:WaitForChild("RovusEventBus")

local Types = require(game.ReplicatedStorage.Shared.rovusTypes)
local Util = require(game.ReplicatedStorage.Shared.rovusUtil)

local RovusClient = {}

function RovusClient.bind()
	-- Always handle events defensively.
	RovusEventBus.OnClientEvent:Connect(function(message)
		message = type(message) == "table" and message or {}
		local mType = message.type

		if mType == Types.MESSAGE_TYPE.ENGINE_BOOTSTRAP then
			-- For now, only log. Later this drives UI + task orchestration.
			print("[ROVUS] Engine bootstrap received")
			return
		end

		if mType == Types.MESSAGE_TYPE.TASK_PROGRESS then
			print("[ROVUS] Task progress:", message.payload and message.payload.status)
			return
		end

		if mType == Types.MESSAGE_TYPE.TASK_RESULT then
			print("[ROVUS] Task result received")
			return
		end

		if mType == Types.MESSAGE_TYPE.TASK_ERROR then
			print("[ROVUS] Task error:", message.payload and message.payload.error)
			return
		end
	end)

	-- Proactively notify the server that the client is alive.
	-- (This is safe and doesn't execute arbitrary code.)
	RovusEventBus:FireServer({
			id = Util.newId("client"),
			type = Types.MESSAGE_TYPE.TASK_REQUEST,
			payload = {
				kind = "HELLO",
			},
	})
end

return RovusClient

