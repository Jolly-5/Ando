-- src/server/init.server.luau

local RovusServer = require(script.Parent:WaitForChild("rovusServer"))
local RovusUiServer = require(script:WaitForChild("rovusUi.server"))

local CombatServer = require(script.Parent:WaitForChild("Systems"):WaitForChild("Combat"):WaitForChild("CombatServer"))

RovusUiServer.bind()
RovusServer.bind()
CombatServer.bind()


