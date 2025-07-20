-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    02/07/2025 23:20:03
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local createCleanup = _vivid.createCleanup
local createEffect = _vivid.createEffect
local createScope = _vivid.createScope
local createState = _vivid.createState
local SettingsContext = TS.import(script, script.Parent, "SettingsContexts").SettingsContext
local Tags = TS.import(script, script.Parent.Parent, "Core", "Constants", "Tags").Tags
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
--[[
	
	type SelectionServiceType = Selection & { SelectionChanged: RBXScriptSignal };
	const SelectionService = game.GetService("Selection") as SelectionServiceType;
	
]]
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local RuntimeContextsScope = createScope()
local CurrentlyHoveringItems, setCurrentlyHoveringItems = createState({})
local CurrentlyHoveringItemsUnfiltered, setCurrentlyHoveringItemsUnfiltered = createState({})
local CurrentlySelectedItems, setCurrentlySelectedItems = createState({})
-- Hovering
createEffect(function()
	if SettingsContext.HoverDetectionEnabled.get() == false then
		return nil
	end
	--[[
		
			let Selections = SelectionService.Get();
			const SelectionChanged = SelectionService.SelectionChanged.Connect(() => {
				Selections = SelectionService.Get();
			});
			
	]]
	local MultiHoverDetectionEnabled = SettingsContext.MultiHoverDetectionEnabled.get()
	local IgnoreTransparentGUIObjects = SettingsContext.IgnoreTransparentGUIObjects.get()
	local UseHoverDetectionActivationKeybind = SettingsContext.UseHoverDetectionActivationKeybind.get()
	local Update = RunService.Heartbeat:Connect(function()
		if UseHoverDetectionActivationKeybind == true then
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) == false then
				setCurrentlyHoveringItems(function(old)
					if #old == 0 then
						return old
					end
					return {}
				end)
				return nil
			end
		end
		local _exp = UserInputService:GetMouseLocation()
		local _vector2 = Vector2.new(0, GuiService.TopbarInset.Height)
		local MouseLocation = _exp - _vector2
		local _exp_1 = PlayerGui:GetGuiObjectsAtPosition(MouseLocation.X, MouseLocation.Y)
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#_exp_1)
		local _callback = function(f)
			if f:HasTag(Tags.IgnoreHoverDetection) == true then
				return nil
			end
			return f
		end
		for _k, _v in _exp_1 do
			_newValue[_k] = _callback(_v, _k - 1, _exp_1)
		end
		-- ▲ ReadonlyArray.map ▲
		-- ▼ ReadonlyArray.filterUndefined ▼
		local _length = 0
		for _i in _newValue do
			if _i > _length then
				_length = _i
			end
		end
		local _result = {}
		local _resultLength = 0
		for _i = 1, _length do
			local _v = _newValue[_i]
			if _v ~= nil then
				_resultLength += 1
				_result[_resultLength] = _v
			end
		end
		-- ▲ ReadonlyArray.filterUndefined ▲
		local AllGuiObjectsAtPosition = _result
		setCurrentlyHoveringItemsUnfiltered(AllGuiObjectsAtPosition)
		-- ▼ ReadonlyArray.map ▼
		local _newValue_1 = table.create(#AllGuiObjectsAtPosition)
		local _callback_1 = function(f)
			--[[
				
							if (Selections.indexOf(f) > -1) {
								return;
							}
							
			]]
			if IgnoreTransparentGUIObjects == true then
				if f:IsA("TextLabel") or f:IsA("TextBox") or f:IsA("TextButton") then
					if f.TextTransparency == 1 and f.BackgroundTransparency == 1 then
						return nil
					end
				elseif f:IsA("ImageLabel") then
					if f.ImageTransparency == 1 then
						return nil
					end
				else
					if f.BackgroundTransparency == 1 then
						return nil
					end
				end
			end
			return f
		end
		for _k, _v in AllGuiObjectsAtPosition do
			_newValue_1[_k] = _callback_1(_v, _k - 1, AllGuiObjectsAtPosition)
		end
		-- ▲ ReadonlyArray.map ▲
		-- ▼ ReadonlyArray.filterUndefined ▼
		local _length_1 = 0
		for _i in _newValue_1 do
			if _i > _length_1 then
				_length_1 = _i
			end
		end
		local _result_1 = {}
		local _resultLength_1 = 0
		for _i = 1, _length_1 do
			local _v = _newValue_1[_i]
			if _v ~= nil then
				_resultLength_1 += 1
				_result_1[_resultLength_1] = _v
			end
		end
		-- ▲ ReadonlyArray.filterUndefined ▲
		local GuiObjectsAtPosition = _result_1
		if MultiHoverDetectionEnabled == false then
			local Target = GuiObjectsAtPosition[1]
			if Target == nil then
				GuiObjectsAtPosition = {}
			else
				GuiObjectsAtPosition = { Target }
			end
		end
		setCurrentlyHoveringItems(function(old)
			if #old == 0 and #GuiObjectsAtPosition == 0 then
				return old
			end
			local OldAndNewMatches = 0
			-- NOTE: not sure how performant this will be, but it is more performant than having vivid rerender the state even if the same items are being hovered.
			-- ▼ ReadonlyArray.forEach ▼
			local _callback_2 = function(oldItem)
				local _guiObjectsAtPosition = GuiObjectsAtPosition
				local _oldItem = oldItem
				if (table.find(_guiObjectsAtPosition, _oldItem) or 0) - 1 == -1 then
					return nil
				end
				OldAndNewMatches += 1
			end
			for _k, _v in old do
				_callback_2(_v, _k - 1, old)
			end
			-- ▲ ReadonlyArray.forEach ▲
			if OldAndNewMatches == #GuiObjectsAtPosition and #old == OldAndNewMatches then
				return old
			end
			return GuiObjectsAtPosition
		end)
	end)
	createCleanup(function()
		setCurrentlyHoveringItems({})
		--[[
			
					SelectionChanged.Disconnect();
					
		]]
		Update:Disconnect()
	end)
end)
--[[
	
	// Selected
	createEffect(() => {
		if (SettingsContext.SelectedDetectionEnabled.get() === false) {
			return;
		}
	
		setCurrentlySelectedItems(
			SelectionService.Get()
				.map((f) => (f.IsA("GuiObject") ? f : undefined))
				.filterUndefined(),
		);
		const Update = SelectionService.SelectionChanged.Connect(() => {
			setCurrentlySelectedItems(
				SelectionService.Get()
					.map((f) => (f.IsA("GuiObject") ? f : undefined))
					.filterUndefined(),
			);
		});
	
		createCleanup(() => {
			setCurrentlyHoveringItems([]);
			Update.Disconnect();
		});
	});
	
]]
RuntimeContextsScope.Close()
return {
	CurrentlyHoveringItems = CurrentlyHoveringItems,
	setCurrentlyHoveringItems = setCurrentlyHoveringItems,
	CurrentlyHoveringItemsUnfiltered = CurrentlyHoveringItemsUnfiltered,
	setCurrentlyHoveringItemsUnfiltered = setCurrentlyHoveringItemsUnfiltered,
	CurrentlySelectedItems = CurrentlySelectedItems,
	setCurrentlySelectedItems = setCurrentlySelectedItems,
}
