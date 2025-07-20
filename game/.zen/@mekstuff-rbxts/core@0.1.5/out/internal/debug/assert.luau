-- Compiled with roblox-ts v3.0.0
local assertp = function(condition, err)
	local _condition = condition
	local _arg1 = `\n⬇ PSEUDO CAUGHT ASSERT ⬇\n-~~~~~\n{err}\n~~~~~-`
	return assert(_condition ~= 0 and _condition == _condition and _condition ~= "" and _condition, _arg1)
end
return {
	assertp = assertp,
}
