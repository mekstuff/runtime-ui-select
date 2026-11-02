-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/02/2025 23:11:33
	
]]
local createElement = TS.import(script, script.Parent, "createElement").createElement
local _FragmentIdentifier_ = TS.import(script, script.Parent.Parent, "internal", "Fragment")._FragmentIdentifier_
local _FragmentSlotsEntries = TS.import(script, script.Parent.Parent, "internal", "FragmentSlotsEntries")
local FireSlotEntryAddedSignal = _FragmentSlotsEntries.FireSlotEntryAddedSignal
local FragmentSlotEntries = _FragmentSlotsEntries.FragmentSlotEntries
local createState = TS.import(script, script.Parent, "createState").createState
-- TODO: (IMPORTANT) - <Slot slotId/> will not render content as intended, use <Slot slotId></Slot> when using JSX
-- Experienced while working on SelectionView, not thourougly investaged. Could be how JSX compiles or our code itself.
-- <Slot/> basically was not being considered a child of the parent so `ResolveChildren` didn't know it existed.
-- ^^ Initially diagnosis seems to be wrong, error occurs when the Slot is #1 of the children, for some reason it is excluded.
local function createSlot(props)
	-- NOTE: this kind of breaks multi vivid usage in a larger scaler since two different projects can use the same slotId and get an error (assuming both projects use the same module of vivid ~node_modules~ for e.g.).
	local _arg0 = FragmentSlotEntries[props.slotId] == nil
	local _arg1 = `createSlot(\{slotId: "{props.slotId}"\}) failed since "{props.slotId}" already exists.`
	assert(_arg0, _arg1)
	local SlotChildren, setSlotChildren = createState(nil)
	local FragmentSlot = createElement(_FragmentIdentifier_, nil, SlotChildren())
	FragmentSlot.Destroying:Connect(function()
		FragmentSlotEntries[props.slotId] = nil
	end)
	FragmentSlot._data_fields = FragmentSlot._data_fields or {}
	FragmentSlot._data_fields.setSlotChildren = setSlotChildren
	FragmentSlotEntries[props.slotId] = FragmentSlot
	FireSlotEntryAddedSignal(props.slotId)
	return FragmentSlot
end
return {
	createSlot = createSlot,
}
