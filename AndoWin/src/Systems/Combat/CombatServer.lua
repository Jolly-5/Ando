-- src/Systems/Combat/CombatServer.lua
-- Server wiring for the Combat system.

local Players = game:GetService("Players")

local SkillSlots = require(script.Parent.skills.SkillSlots)

local CombatServer = {}

function CombatServer.bind()
	Players.PlayerAdded:Connect(function(player)
		SkillSlots.ensureCombatSlot(player)
	end)

	for _, player in ipairs(Players:GetPlayers()) do
		pcall(function()
			SkillSlots.ensureCombatSlot(player)
		end)
	end
end
  
return CombatServer

