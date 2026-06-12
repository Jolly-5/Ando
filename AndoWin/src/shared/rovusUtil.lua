-- src/shared/rovusUtil.lua
-- Small shared utilities.

local ROVUS_UTIL = {}

function ROVUS_UTIL.newId(prefix)
	prefix = prefix or "rovus"
	-- Not cryptographically secure; good enough for local session correlation.
	return prefix .. "_" .. tostring(os.clock()) .. "_" .. tostring(math.random(1, 1e8))
end

function ROVUS_UTIL.safeString(s, default)
	if type(s) == "string" and #s > 0 then
		return s
	end
	return default or ""
end

function ROVUS_UTIL.safeTable(t)
	if type(t) == "table" then
		return t
	end
	return {}
end

return ROVUS_UTIL

