-- src/server/rovusServer.lua
-- Server-side bootstrap for ROVUS.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Types = require(ReplicatedStorage.Shared.rovusTypes)
local Util = require(ReplicatedStorage.Shared.rovusUtil)
local EventBus = require(ReplicatedStorage.Shared.rovusEventBus)

local RovusServer = {}

local function ensureRemoteEvent()
	local ev = ReplicatedStorage:FindFirstChild(EventBus.REMOTE_EVENT_NAME)
	if ev and ev:IsA("RemoteEvent") then
		return ev
	end

	ev = Instance.new("RemoteEvent")
	ev.Name = EventBus.REMOTE_EVENT_NAME
	ev.Parent = ReplicatedStorage
	return ev
end

function RovusServer.bind()
	local remote = ensureRemoteEvent()

	-- Broadcast bootstrap to all clients.
	remote:FireAllClients({
		id = Util.newId("boot"),
		type = Types.MESSAGE_TYPE.ENGINE_BOOTSTRAP,
		payload = {
			version = 1,
			message = "ROVUS runtime bootstrapped",
		},
	})

	remote.OnServerEvent:Connect(function(player, message)
		message = type(message) == "table" and message or {}
		local mType = message.type
		local payload = type(message.payload) == "table" and message.payload or {}

		-- Keep this strictly non-executable: no dynamic code loading.
		if mType == Types.MESSAGE_TYPE.TASK_REQUEST then
			local kind = payload.kind

			if kind == "HELLO" then
				remote:FireClient(player, {
					id = Util.newId("task"),
					type = Types.MESSAGE_TYPE.TASK_ACCEPTED,
					payload = {
						status = Types.TASK_STATUS.RUNNING,
						description = "Handshake accepted",
					},
				})

				remote:FireClient(player, {
					id = Util.newId("task"),
					type = Types.MESSAGE_TYPE.TASK_RESULT,
					payload = {
						status = Types.TASK_STATUS.SUCCEEDED,
						result = "ROVUS connected",
					},
				})
				return
			end

			remote:FireClient(player, {
					id = Util.newId("task"),
					type = Types.MESSAGE_TYPE.TASK_ERROR,
					payload = {
						status = Types.TASK_STATUS.FAILED,
						error = "Unknown task kind",
					},
				})
			return
		end
	end)
end

return RovusServer

