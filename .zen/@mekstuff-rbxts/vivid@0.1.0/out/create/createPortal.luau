-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/02/2025 23:13:45
	
]]
local createElement = TS.import(script, script.Parent, "createElement").createElement
local _FragmentIdentifier_ = TS.import(script, script.Parent.Parent, "internal", "Fragment")._FragmentIdentifier_
local _FragmentSlotsEntries = TS.import(script, script.Parent.Parent, "internal", "FragmentSlotsEntries")
local FragmentSlotEntries = _FragmentSlotsEntries.FragmentSlotEntries
local GetFragmentSlotEntryAddedSignal = _FragmentSlotsEntries.GetFragmentSlotEntryAddedSignal
local GetElementNode = TS.import(script, script.Parent.Parent, "nodes", "Nodes").GetElementNode
--[[
	*
	// TODO: (use a different method possibly) frame gets parented to slot but frame gets parented to textlabel after since it's a child.
	// Added a task.defer to createPortal `UpdateSlotFragmentChildren` but this means frame will be rendered
	// inside the Portal fragment which means if fragment is parented to something, frame will render there
	// until the end of frame.
	
	DemoCode:
	
	createElement(() => (
		<screengui Parent={game.Workspace}>
			<Slot slotId="test" />
			</screengui>
		));
		
		createElement(() => (
			<textlabel Parent={game.Workspace} Name={"Held Portal"}>
				<Portal slot="test">
					<frame Name={"Within Portal"} />
				</Portal>
			</textlabel>
		));
		
	 
]]
--* 
local function UpdateSlotFragmentChildren(SlotFragment, children)
	local _result = SlotFragment._data_fields
	if _result ~= nil then
		_result = _result.setSlotChildren
	end
	local setSlotChildrenFunc = _result
	local _arg0 = setSlotChildrenFunc ~= nil
	local _arg1 = `Fragment provided may not be a Slot fragment. missing setSlotChildren datafield`
	assert(_arg0, _arg1)
	task.defer(function()
		setSlotChildrenFunc(children)
	end)
end
local function createPortal(props)
	if props.mount ~= nil and props.slot ~= nil then
		error(`You cannot define both "mount" and "slot" for a Portal.`)
	end
	local _slot = props.slot
	if type(_slot) == "string" then
		-- slot portal mounting
		local RootElementNode = GetElementNode()
		local _arg0 = RootElementNode ~= nil
		local _arg1 = `Cannot createPortal that is mounted to a slot outside of a Element Node.`
		assert(_arg0, _arg1)
		local TargetFragmentSlot = FragmentSlotEntries[props.slot]
		if TargetFragmentSlot == nil then
			-- add synchronously, we do not yield until slot is found.
			local ListenerConnection
			ListenerConnection = GetFragmentSlotEntryAddedSignal():Connect(function(SlotId)
				if SlotId == props.slot then
					UpdateSlotFragmentChildren(FragmentSlotEntries[props.slot], props.children)
					ListenerConnection:Disconnect()
				end
			end)
			RootElementNode.servant:Keep(ListenerConnection)
		else
			-- already existed, add now.
			UpdateSlotFragmentChildren(TargetFragmentSlot, props.children)
		end
		return createElement(_FragmentIdentifier_, {
			_force_mounted = true,
		}, props.children)
	end
	-- normal portal mounting
	return createElement(_FragmentIdentifier_, {
		_force_mounted = if props.mount == nil then nil else true,
		Parent = props.mount,
	}, props.children)
end
return {
	createPortal = createPortal,
}
