-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    05/07/2025 18:37:43
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local createCleanup = _vivid.createCleanup
local createEffect = _vivid.createEffect
local createScope = _vivid.createScope
local use = _vivid.use
local CurrentlyHoveringItems = TS.import(script, script.Parent.Parent.Parent, "Contexts", "RuntimeContexts").CurrentlyHoveringItems
local SettingsContext = TS.import(script, script.Parent.Parent.Parent, "Contexts", "SettingsContexts").SettingsContext
local RuntimeContextMenuOpened = TS.import(script, script.Parent, "RuntimeContextMenu").RuntimeContextMenuOpened
local SelectionService = game:GetService("Selection")
local UserInputService = game:GetService("UserInputService")
local RuntimeUISelectionScope = createScope()
createEffect(function()
	local RuntimeUISelectionEnabled = SettingsContext.AllowUserRuntimeUISelection.get() == true
	if RuntimeUISelectionEnabled == false then
		return nil
	end
	local ClickListener = UserInputService.InputBegan:Connect(function(Input)
		if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then
			return nil
		end
		if use(function()
			return RuntimeContextMenuOpened()
		end) then
			return nil
		end
		local HoveringItems = use(function()
			return CurrentlyHoveringItems()
		end)
		local TargetItem = HoveringItems[1]
		if TargetItem == nil then
			SelectionService:Set({})
			return nil
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
			local CurrentSelections = SelectionService:Get()
			local IndexOf = (table.find(CurrentSelections, TargetItem) or 0) - 1
			if IndexOf > -1 then
				table.remove(CurrentSelections, IndexOf + 1)
				SelectionService:Set(CurrentSelections)
			else
				local _array = {}
				local _length = #_array
				local _array_1 = SelectionService:Get()
				local _Length = #_array_1
				table.move(_array_1, 1, _Length, _length + 1, _array)
				_length += _Length
				_array[_length + 1] = TargetItem
				SelectionService:Set(_array)
			end
		else
			SelectionService:Set({ TargetItem })
		end
	end)
	createCleanup(function()
		ClickListener:Disconnect()
	end)
end)
RuntimeUISelectionScope.Close()
return nil
