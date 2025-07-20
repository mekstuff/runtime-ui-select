-- Compiled with roblox-ts v3.0.0
local warnp = function(...)
	local args = { ... }
	args[#args + 2] = `\n~~~~~-`
	return warn(`\n⬇ PSEUDO CAUGHT WARN ⬇\n-~~~~~\n`, unpack(args))
end
return {
	warnp = warnp,
}
