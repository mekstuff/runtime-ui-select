-- Compiled with roblox-ts v3.0.0
local errorp = function(err, level)
	level = if level == nil then 2 else level
	return error(`\n⬇ PSEUDO CAUGHT ERROR ⬇\n-~~~~~\n{err}\n~~~~~-`, level)
end
return {
	errorp = errorp,
}
