-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    06/06/2025 00:25:41
	
]]
local PseudoCollector = TS.import(script, script.Parent.Parent.Parent, "internal", "functions", "GetPseudoById").PseudoCollector
local Pseudo = TS.import(script, script.Parent.Parent, "Pseudo", "Pseudo").Pseudo
local Players = game:GetService("Players")
local RuntimeDebuggerRoot
do
	local super = Pseudo
	RuntimeDebuggerRoot = setmetatable({}, {
		__tostring = function()
			return "RuntimeDebuggerRoot"
		end,
		__index = super,
	})
	RuntimeDebuggerRoot.__index = RuntimeDebuggerRoot
	function RuntimeDebuggerRoot.new(...)
		local self = setmetatable({}, RuntimeDebuggerRoot)
		return self:constructor(...) or self
	end
	function RuntimeDebuggerRoot:constructor(RuntimeDebugger)
		super.constructor(self, "RuntimeDebuggerRoot")
		self.UserUsageList = {}
		self.IsActiveFromUserUsage = false
		self.SharedPseudoCollector = {}
		local UpdateSharedPseudoCollector = function()
			for ExistingId in pairs(self.SharedPseudoCollector) do
				if PseudoCollector[ExistingId] ~= nil then
					continue
				end
				self.SharedPseudoCollector[ExistingId] = nil
			end
			for PseudoId, PseudoObject in pairs(PseudoCollector) do
				if PseudoObject == self or PseudoObject == RuntimeDebugger then
					continue
				end
				if PseudoObject.ClassName == "PseudoClientReplicator" then
					continue
				end
				local _object = table.clone((PseudoObject:_getCurrentProperties(nil, nil, nil, nil, true)))
				setmetatable(_object, nil)
				for _k, _v in {
					_dev = {
						_internal_runtime_debug_info = PseudoObject._dev._internal_runtime_debug_info,
					},
				} do
					_object[_k] = _v
				end
				self.SharedPseudoCollector[PseudoId] = _object
			end
			self:useNewIndexAssignment("SharedPseudoCollector", self.SharedPseudoCollector)
		end
		self:Observe(function()
			if self.IsActiveFromUserUsage == false then
				return nil
			end
			UpdateSharedPseudoCollector()
			local IsActive = true
			task.spawn(function()
				while true do
					task.wait(1)
					if IsActive == false then
						break
					end
					UpdateSharedPseudoCollector()
				end
			end)
			return function()
				IsActive = false
				self.SharedPseudoCollector = {}
				self:useNewIndexAssignment("SharedPseudoCollector", self.SharedPseudoCollector)
			end
		end, { "IsActiveFromUserUsage" })
		self:Observe(function()
			self.IsActiveFromUserUsage = #self.UserUsageList > 0
		end, { "UserUsageList" })
		Players.PlayerRemoving:Connect(function(Player)
			self:RemoveUserUsage(Player)
		end)
	end
	function RuntimeDebuggerRoot:GetIsVerifiedUsageUser(Player)
		local _userUsageList = self.UserUsageList
		local _player = Player
		return (table.find(_userUsageList, _player) or 0) - 1 > -1
	end
	function RuntimeDebuggerRoot:AddUserUsage(Player)
		local _userUsageList = self.UserUsageList
		local _player = Player
		if (table.find(_userUsageList, _player) or 0) - 1 > -1 then
			return nil
		end
		local _userUsageList_1 = self.UserUsageList
		local _player_1 = Player
		table.insert(_userUsageList_1, _player_1)
		self:useNewIndexAssignment("UserUsageList", self.UserUsageList)
	end
	function RuntimeDebuggerRoot:RemoveUserUsage(Player)
		local _userUsageList = self.UserUsageList
		local _player = Player
		local IndexOf = (table.find(_userUsageList, _player) or 0) - 1
		if IndexOf < 0 then
			return nil
		end
		table.remove(self.UserUsageList, IndexOf + 1)
		self:useNewIndexAssignment("UserUsageList", self.UserUsageList)
	end
end
return {
	RuntimeDebuggerRoot = RuntimeDebuggerRoot,
}
