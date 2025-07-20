-- Compiled with roblox-ts v3.0.0
local logp = function(...)
	local args = { ... }
	return print(`[PHe]:`, unpack(args))
end
return {
	logp = logp,
}
