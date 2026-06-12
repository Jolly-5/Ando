-- src/server/rovusUi.server.luau
-- Minimal UI injection placeholder.
-- Creates a ScreenGui and a small status label.

local Players = game:GetService("Players")

local RovusUiServer = {}

local function ensureGui(player)
	local playerGui = player:WaitForChild("PlayerGui")
	local existing = playerGui:FindFirstChild("RovusGui")
	if existing then
		return
	end

	local gui = Instance.new("ScreenGui")
	gui.Name = "RovusGui"
	gui.ResetOnSpawn = false
	gui.Parent = playerGui

	local label = Instance.new("TextLabel")
	label.Name = "StatusLabel"
	label.BackgroundTransparency = 0.25
	label.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	label.BorderSizePixel = 0
	label.TextColor3 = Color3.fromRGB(230, 230, 230)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 18
	label.Text = "ROVUS: connecting..."
	label.Size = UDim2.fromOffset(360, 40)
	label.Position = UDim2.new(0, 12, 0, 12)
	label.Parent = gui
end

function RovusUiServer.bind()
	Players.PlayerAdded:Connect(function(player)
		ensureGui(player)
	end)

	-- Also handle already-connected players.
	for _, player in ipairs(Players:GetPlayers()) do
		pcall(function()
			ensureGui(player)
		end)
	end
end

return RovusUiServer

