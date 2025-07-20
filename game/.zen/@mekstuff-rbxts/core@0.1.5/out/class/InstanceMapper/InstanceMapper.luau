-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local Pseudo = TS.import(script, script.Parent.Parent, "Pseudo", "Pseudo").Pseudo
local InstanceMap
do
	local super = Pseudo
	InstanceMap = setmetatable({}, {
		__tostring = function()
			return "InstanceMap"
		end,
		__index = super,
	})
	InstanceMap.__index = InstanceMap
	function InstanceMap.new(...)
		local self = setmetatable({}, InstanceMap)
		return self:constructor(...) or self
	end
	function InstanceMap:constructor(MappedItem)
		super.constructor(self, "InstanceMap", MappedItem)
		local _condition = (MappedItem.Name)
		if _condition == nil then
			_condition = self.Name
		end
		self.Name = _condition
		self:useIndexAssignment(function(key, value)
			if value ~= nil then
				return value
			end
			local s, r = pcall(function()
				local _key = key
				local _condition_1 = type(_key) == "string"
				if _condition_1 then
					_condition_1 = (string.match(key, "^_"))
				end
				if _condition_1 ~= 0 and _condition_1 == _condition_1 and _condition_1 ~= "" and _condition_1 then
					return nil
				end
				return MappedItem[key]
			end)
			if not s then
				warn(`Instance Mapper Error on: "{MappedItem}" || "{self}" :: {r}\n{debug.traceback(nil, 2)}`)
			end
			if s then
				return r
			end
			return value
		end)
	end
end
local InstanceMapperClass
do
	local super = Pseudo
	InstanceMapperClass = setmetatable({}, {
		__tostring = function()
			return "InstanceMapperClass"
		end,
		__index = super,
	})
	InstanceMapperClass.__index = InstanceMapperClass
	function InstanceMapperClass.new(...)
		local self = setmetatable({}, InstanceMapperClass)
		return self:constructor(...) or self
	end
	function InstanceMapperClass:constructor()
		super.constructor(self, "InstanceMapper")
	end
	function InstanceMapperClass:New(target)
		local targetInstance
		local _target = target
		if type(_target) == "string" then
			targetInstance = Instance.new(target)
		else
			targetInstance = target
		end
		local IMAP = InstanceMap.new(targetInstance)
		IMAP.PropertyChanged:Connect(function(key, value)
			local s, r = pcall(function()
				local _key = key
				local _condition = type(_key) == "string"
				if _condition then
					_condition = (string.match(key, "^_"))
				end
				if _condition ~= 0 and _condition == _condition and _condition ~= "" and _condition then
					return nil
				end
				targetInstance[key] = value
			end)
			if not s then
				self:warn(`Instance Mapper Error on: "{targetInstance}" || "{self}" :: {r} {debug.traceback(nil, 2)}`)
			end
		end)
		return IMAP
	end
end
local InstanceMapper = InstanceMapperClass.new()
local default = InstanceMapper
return {
	InstanceMapperClass = InstanceMapperClass,
	InstanceMapper = InstanceMapper,
	default = default,
}
