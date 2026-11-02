-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local _core = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "core").out)
local Pseudo = _core.Pseudo
local Servant = _core.Servant
local GetPseudoFromObject = _core.GetPseudoFromObject
local tryUseEffectCleanup = _core.tryUseEffectCleanup
local CollectionService = game:GetService("CollectionService")
--*If target is a pseudo then it gets the pseudo
local GetObject = function(Target)
	return GetPseudoFromObject(Target) or Target
end
--*If target is a pseudo then returns the ref instance
local GetInstance = function(Target)
	local _target = Target
	if typeof(_target) == "Instance" then
		return Target
	end
	return Target:GetRef()
end
--*
local Collector
do
	local super = Pseudo
	Collector = setmetatable({}, {
		__tostring = function()
			return "Collector"
		end,
		__index = super,
	})
	Collector.__index = Collector
	function Collector.new(...)
		local self = setmetatable({}, Collector)
		return self:constructor(...) or self
	end
	function Collector:constructor()
		super.constructor(self, "Collector")
	end
	function Collector:GetTagged(TagName)
		local Tagged = {}
		local AllTagged = CollectionService:GetTagged(TagName)
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(instance)
			local _arg0 = GetObject(instance)
			table.insert(Tagged, _arg0)
			-- Tagged.push(GetInstance(instance));
		end
		for _k, _v in AllTagged do
			_callback(_v, _k - 1, AllTagged)
		end
		-- ▲ ReadonlyArray.forEach ▲
		return Tagged
	end
	function Collector:Tag(instance, TagName)
		if instance == nil then
			error(`Instance | Pseudo expected, got undefined`)
		end
		CollectionService:AddTag(GetInstance(instance), TagName)
	end
	function Collector:RemoveTag(instance, TagName)
		CollectionService:RemoveTag(GetInstance(instance), TagName)
	end
	function Collector:Bind(TagName, Callback)
		local cleanups = {}
		local BindServant = Servant.new()
		local ExecuteCallback = function(_obj)
			local __obj = _obj
			local oldcleanup = cleanups[__obj]
			if oldcleanup ~= nil then
				tryUseEffectCleanup(oldcleanup)
				local __obj_1 = _obj
				cleanups[__obj_1] = nil
			end
			local cleanupret = Callback(GetObject(_obj), BindServant)
			if cleanupret == nil then
				local __obj_1 = _obj
				cleanups[__obj_1] = nil
				return nil
			end
			if type(cleanupret) == "function" ~= true then
				self:error(`YOU SHOULD NOT RETURN ANYTHING OTHER THAT A FUNCTION (FOR CLEANUP) TO A BIND FUNCTION. Returning a Servant for Example will siginificantly memory usage performance`)
			end
			local __obj_1 = _obj
			cleanups[__obj_1] = cleanupret
		end
		local Tagged = CollectionService:GetTagged(TagName)
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(e)
			ExecuteCallback(e)
		end
		for _k, _v in Tagged do
			_callback(_v, _k - 1, Tagged)
		end
		-- ▲ ReadonlyArray.forEach ▲
		BindServant:Keep(CollectionService:GetInstanceAddedSignal(TagName):Connect(function(instance)
			ExecuteCallback(instance)
		end))
		BindServant:Keep(CollectionService:GetInstanceRemovedSignal(TagName):Connect(function(instance)
			local _instance = instance
			local cleaner = cleanups[_instance]
			if cleaner ~= nil then
				tryUseEffectCleanup(cleaner, true)
				local _instance_1 = instance
				cleanups[_instance_1] = nil
			end
		end))
		BindServant.Destroying:Connect(function()
			-- ▼ ReadonlyMap.forEach ▼
			local _callback_1 = function(cleanup, instance)
				local _instance = instance
				cleanups[_instance] = nil
				tryUseEffectCleanup(cleanup, true)
			end
			for _k, _v in cleanups do
				_callback_1(_v, _k, cleanups)
			end
			-- ▲ ReadonlyMap.forEach ▲
		end)
		return BindServant
	end
end
local COLLECTOR = Collector.new()
local default = COLLECTOR
return {
	default = default,
	Collector = COLLECTOR,
}
