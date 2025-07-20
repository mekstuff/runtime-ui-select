-- Compiled with roblox-ts v3.0.0-dev-d48bd20
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/02/2025 23:21:22
	
]]
local Signal = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "core").out).Signal
local GetElementNode = TS.import(script, script.Parent.Parent, "nodes", "Nodes").GetElementNode
local FragmentSlotEntryAddedSignal = nil
local GetFragmentSlotEntryAddedSignal = function()
	if FragmentSlotEntryAddedSignal ~= nil then
		return FragmentSlotEntryAddedSignal
	end
	local RootElementNode = GetElementNode()
	local _arg0 = RootElementNode ~= nil
	local _arg1 = `Cannot GetFragmentSlotEntryAddedSignal that is mounted to a slot outside of a Element Node. (Attempted to Create Added Signal Object)`
	assert(_arg0, _arg1)
	FragmentSlotEntryAddedSignal = Signal.new()
	RootElementNode.servant:Keep(FragmentSlotEntryAddedSignal)
	return FragmentSlotEntryAddedSignal
end
local FireSlotEntryAddedSignal = function(SlotId)
	if FragmentSlotEntryAddedSignal == nil then
		return nil
	end
	FragmentSlotEntryAddedSignal:Fire(SlotId)
end
local FragmentSlotEntries = {}
return {
	GetFragmentSlotEntryAddedSignal = GetFragmentSlotEntryAddedSignal,
	FireSlotEntryAddedSignal = FireSlotEntryAddedSignal,
	FragmentSlotEntries = FragmentSlotEntries,
}
