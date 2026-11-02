-- Compiled with roblox-ts v3.0.0
local _FragmentIdentifier_ = "__VIVID.FRAGMENT__"
local function IsInternalFragment(Target)
	local _target = Target
	if not (type(_target) == "table") then
		return false
	end
	if Target._is_fragment == true then
		return true
	end
	return false
end
local function CreateInternalFragment()
	local _is_destroyed = false
	local destroying_callbacks = {}
	local fragment = {
		_is_fragment = true,
		children = nil,
		Destroy = function()
			if _is_destroyed == true then
				return nil
			end
			_is_destroyed = true
			if destroying_callbacks ~= nil then
				-- ▼ ReadonlyArray.forEach ▼
				local _callback = function(x)
					return x()
				end
				for _k, _v in destroying_callbacks do
					_callback(_v, _k - 1, destroying_callbacks)
				end
				-- ▲ ReadonlyArray.forEach ▲
			end
		end,
		Destroying = {
			Connect = function(_, Callback)
				if _is_destroyed then
					Callback()
					return nil
				end
				destroying_callbacks = destroying_callbacks or {}
				local _destroying_callbacks = destroying_callbacks
				local _callback = Callback
				table.insert(_destroying_callbacks, _callback)
			end,
		},
	}
	return fragment
end
return {
	IsInternalFragment = IsInternalFragment,
	CreateInternalFragment = CreateInternalFragment,
	_FragmentIdentifier_ = _FragmentIdentifier_,
}
