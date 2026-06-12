-- src/Systems/Combat/skills/SkillSlots.lua
-- Simple helper for creating a player "skill slots" folder and populating slots.

local SkillSlots = {}

-- Creates/ensures a "Skills" folder under the player's inventory container.
-- We use leaderstats-like Instances to keep it easy to inspect in Studio.
function SkillSlots.ensureForPlayer(player)
	local inv = player:FindFirstChild("Inventory")
	if not inv then
		inv = Instance.new("Folder")
		inv.Name = "Inventory"
		inv.Parent = player
	end

	local skills = inv:FindFirstChild("Skills")
	if not skills then
		skills = Instance.new("Folder")
		skills.Name = "Skills"
		skills.Parent = inv
	end

	return skills
end

function SkillSlots.ensureCombatSlot(player)
	local skills = SkillSlots.ensureForPlayer(player)

	local combat = skills:FindFirstChild("Combat")
	if combat then
		return
	end

	combat = Instance.new("StringValue")
	combat.Name = "Combat"
	combat.Value = "combat"
	combat.Parent = skills
end

return SkillSlots

