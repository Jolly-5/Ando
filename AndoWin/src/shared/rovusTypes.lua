-- src/shared/rovusTypes.lua
-- Shared type-like definitions for the ROVUS runtime.
-- Luau doesn't enforce types at runtime, but these tables act as a contract.

local ROVUS = {}

-- Message schema between client/server.
-- All messages must include:
--   id: string
--   type: string
--   payload: table

ROVUS.MESSAGE_TYPE = {
	ENGINE_BOOTSTRAP = "ENGINE_BOOTSTRAP",
	TASK_REQUEST = "TASK_REQUEST",
	TASK_ACCEPTED = "TASK_ACCEPTED",
	TASK_PROGRESS = "TASK_PROGRESS",
	TASK_RESULT = "TASK_RESULT",
	TASK_ERROR = "TASK_ERROR",
}

-- Simple status enums.
ROVUS.TASK_STATUS = {
	PENDING = "PENDING",
	RUNNING = "RUNNING",
	SUCCEEDED = "SUCCEEDED",
	FAILED = "FAILED",
}

return ROVUS

