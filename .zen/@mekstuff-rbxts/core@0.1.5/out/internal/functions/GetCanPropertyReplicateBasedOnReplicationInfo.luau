-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local _typeIs = TS.import(script, script.Parent, "typeIs")._typeIs
local _getCanPropertyReplicateBasedOnReplicationInfo = function(ObjectProxy, Key)
	local _replicationParams = ObjectProxy._replicationParams
	local _key = Key
	if not (type(_key) == "string") then
		return false
	end
	local _arg0 = ObjectProxy[Key]
	if type(_arg0) == "function" then
		return false
	end
	if Key == "Name" then
		return false
	end
	if Key == "ClassName" then
		return false
	end
	if Key == "Parent" then
		return false
	end
	local _value = (string.match(Key, "^_"))
	if _value ~= 0 and _value == _value and _value ~= "" and _value then
		return false
	end
	if _typeIs(ObjectProxy[Key], "Pseudo") then
		return false
	end
	if type(_replicationParams) == "boolean" then
		return _replicationParams
	end
	if _replicationParams.filter == nil or _replicationParams.filterType == nil then
		return true
	end
	local _filter = _replicationParams.filter
	local _key_1 = Key
	local indexOfKey = (table.find(_filter, _key_1) or 0) - 1
	if _replicationParams.filterType == Enum.RaycastFilterType.Exclude then
		if indexOfKey == -1 then
			return true
		else
			return false
		end
	else
		if indexOfKey == -1 then
			return false
		else
			return true
		end
	end
end
return {
	_getCanPropertyReplicateBasedOnReplicationInfo = _getCanPropertyReplicateBasedOnReplicationInfo,
}
