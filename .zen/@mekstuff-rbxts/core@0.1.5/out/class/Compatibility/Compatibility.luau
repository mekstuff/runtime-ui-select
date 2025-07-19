-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local Pseudo = TS.import(script, script.Parent.Parent, "Pseudo", "Pseudo").Pseudo
local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local _USECOMPATVAR = { "IsTouchDevice", "IsGamepadDevice", "IsTenFootInterface" }
local CompatibilityUsageClass
do
	local super = Pseudo
	CompatibilityUsageClass = setmetatable({}, {
		__tostring = function()
			return "CompatibilityUsageClass"
		end,
		__index = super,
	})
	CompatibilityUsageClass.__index = CompatibilityUsageClass
	function CompatibilityUsageClass.new(...)
		local self = setmetatable({}, CompatibilityUsageClass)
		return self:constructor(...) or self
	end
	function CompatibilityUsageClass:constructor(Compat, ...)
		local args = { ... }
		super.constructor(self, "CompatibilityUsage")
		local lastWasCompatVar = false
		local Constructed = {}
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(argument, index)
			if index == #args - 1 and #args % 1 == 0 then
				local _argument = argument
				if (table.find(_USECOMPATVAR, _argument) or 0) - 1 ~= -1 then
					local _self = self
					local _exp = index
					local _argument_1 = argument
					_self:error(`else statement value expected at index ({_exp}), got type {typeof(_argument_1)} of value "{argument}". A non compatibilty var is expected as the else statement.`)
				end
				if lastWasCompatVar ~= "" and lastWasCompatVar then
					Constructed[lastWasCompatVar] = argument
					Constructed["!$else"] = nil
				else
					Constructed["!$else"] = argument
				end
				return nil
			end
			if lastWasCompatVar ~= false then
				Constructed[lastWasCompatVar] = argument
				lastWasCompatVar = false
				return nil
			end
			local _argument = argument
			if (table.find(_USECOMPATVAR, _argument) or 0) - 1 == -1 then
				local _self = self
				local _exp = index
				local _argument_1 = argument
				_self:error(`Compatibility var expected at index ({_exp}), got type {typeof(_argument_1)} of value "{argument}". Only {table.concat(_USECOMPATVAR, ", ")} are supported compatibility vars.`)
			end
			lastWasCompatVar = argument
		end
		for _k, _v in args do
			_callback(_v, _k - 1, args)
		end
		-- ▲ ReadonlyArray.forEach ▲
		local vars = {}
		for key in pairs(Constructed) do
			if key == "!$else" then
				continue
			end
			table.insert(vars, key)
		end
		self._dev._internal_compat_track = Compat:Observe(function()
			local _compat = Compat
			for key, value in pairs(Constructed) do
				if _compat[key] ~= nil then
					self._activeFunction = value
					return nil
				end
			end
			if Constructed["!$else"] ~= nil then
				self._activeFunction = Constructed["!$else"]
			else
				self._activeFunction = nil
			end
		end, vars)
		self:Observe(function()
			if self._activeFunction then
				return self._activeFunction()
			end
		end, { "_activeFunction" })
	end
end
local CompatibilityClass
do
	local super = Pseudo
	CompatibilityClass = setmetatable({}, {
		__tostring = function()
			return "CompatibilityClass"
		end,
		__index = super,
	})
	CompatibilityClass.__index = CompatibilityClass
	function CompatibilityClass.new(...)
		local self = setmetatable({}, CompatibilityClass)
		return self:constructor(...) or self
	end
	function CompatibilityClass:constructor()
		super.constructor(self, "Compatibility")
		self.IsTouchDevice = false
		self.IsGamepadDevice = false
		self.IsTenFootInterface = false
		if not RunService:IsClient() then
			return nil
		end
		self.IsTenFootInterface = GuiService:IsTenFootInterface()
		self.IsTouchDevice = UserInputService.TouchEnabled
		self.IsGamepadDevice = UserInputService.GamepadEnabled
		UserInputService.GamepadConnected:Connect(function()
			self.IsTenFootInterface = GuiService:IsTenFootInterface()
			self.IsGamepadDevice = true
		end)
		UserInputService.GamepadDisconnected:Connect(function()
			self.IsTenFootInterface = GuiService:IsTenFootInterface()
			self.IsGamepadDevice = false
		end)
		local Cam = game.Workspace.CurrentCamera
		local _result = Cam
		if _result ~= nil then
			_result = _result:GetPropertyChangedSignal("ViewportSize"):Connect(function()
				self.IsTenFootInterface = GuiService:IsTenFootInterface()
			end)
		end
		self.Name = `{LocalPlayer.Name}-{self.ClassName}`
	end
	function CompatibilityClass:use(...)
		local args = { ... }
		return self:useCompatibility(unpack(args))
	end
	function CompatibilityClass:useCompatibility(...)
		local args = { ... }
		-- return new CompatibilityUsageClass(this, ...args).useState((state, updater) => {
		--     return state;
		-- });
		return CompatibilityUsageClass.new(self, unpack(args))
	end
end
local Compatibility = (if RunService:IsClient() and RunService:IsRunning() then CompatibilityClass.new() else nil)
local default = Compatibility
return {
	CompatibilityUsageClass = CompatibilityUsageClass,
	CompatibilityClass = CompatibilityClass,
	Compatibility = Compatibility,
	default = default,
}
