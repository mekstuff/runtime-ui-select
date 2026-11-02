-- Compiled with roblox-ts v3.0.0
local _FragmentIdentifier_ = "__VIVID.FRAGMENT__"
local function IsInternalProxyInstance(Target)
	local _target = Target
	if not (type(_target) == "table") then
		return false
	end
	if Target._is_proxyInstance == true then
		return true
	end
	return false
end
local function CreateProxyInstance(CreatedInstance, OnIndex)
	local proxyCreatedInstance = setmetatable({
		_is_proxyInstance = true,
		_getInstance = function()
			return CreatedInstance
		end,
	}, {
		__index = OnIndex,
		__newindex = function(_, k, v)
			CreatedInstance[k] = v
		end,
		__tostring = function()
			local _createdInstance = CreatedInstance
			return `ProxyInstance({if typeof(_createdInstance) == "Instance" then CreatedInstance:GetFullName() else CreatedInstance})`
		end,
	})
	return proxyCreatedInstance
end
return {
	IsInternalProxyInstance = IsInternalProxyInstance,
	CreateProxyInstance = CreateProxyInstance,
	_FragmentIdentifier_ = _FragmentIdentifier_,
}
