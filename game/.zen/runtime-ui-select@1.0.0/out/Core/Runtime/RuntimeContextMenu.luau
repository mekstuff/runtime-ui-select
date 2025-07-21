-- Compiled with roblox-ts v3.0.0
local TS = require(script.Parent.Parent.Parent.include.RuntimeLib)
--[[
	
	    Typed with ❤️ @mekstuff
	    17/07/2025 19:33:29
	
]]
local _vivid = TS.import(script, script.Parent.Parent.Parent, "include", "node_modules", "@mekstuff-rbxts", "vivid", "out")
local createCleanup = _vivid.createCleanup
local createEffect = _vivid.createEffect
local createScope = _vivid.createScope
local createState = _vivid.createState
local use = _vivid.use
local Icons = TS.import(script, script.Parent.Parent.Parent, "include", "node_modules", "@mekstuff-rbxts", "vivid-ui", "out").Icons
local _RuntimeContexts = TS.import(script, script.Parent.Parent.Parent, "Contexts", "RuntimeContexts")
local CurrentlyHoveringItems = _RuntimeContexts.CurrentlyHoveringItems
local CurrentlyHoveringItemsUnfiltered = _RuntimeContexts.CurrentlyHoveringItemsUnfiltered
local SettingsContext = TS.import(script, script.Parent.Parent.Parent, "Contexts", "SettingsContexts").SettingsContext
local Constants = TS.import(script, script.Parent.Parent, "Constants", "Constants").Constants
local Tags = TS.import(script, script.Parent.Parent, "Constants", "Tags").Tags
local GetPlugin = TS.import(script, script.Parent.Parent, "Functions", "GetPlugin").GetPlugin
local _Toasts = TS.import(script, script.Parent.Parent.Parent, "UI", "Screens", "Toasts")
local DismissToast = _Toasts.DismissToast
local SendToast = _Toasts.SendToast
local Selection = game:GetService("Selection")
local UserInputService = game:GetService("UserInputService")
local RuntimeContextMenuScope = createScope()
local RuntimeContextMenuOpened, setRuntimeContextMenuOpened = createState(false)
createEffect(function()
	local RightClickForContextMenu = SettingsContext.RightClickForContextMenu.get() == true
	if RightClickForContextMenu == false then
		return nil
	end
	local ContextMenu = GetPlugin():CreatePluginMenu(tostring(math.random()))
	local RightClickListener = UserInputService.InputBegan:Connect(function(Input)
		if Input.UserInputType ~= Enum.UserInputType.MouseButton2 then
			return nil
		end
		local HoveringItems = use(function()
			return CurrentlyHoveringItems()
		end)
		local HoveringItemsUnfiltered = use(function()
			return CurrentlyHoveringItemsUnfiltered()
		end)
		if #HoveringItems <= 0 then
			return nil
		end
		local SelectCurrentGuiPluginAction = ContextMenu:AddNewAction(tostring(math.random()), `Select {HoveringItems[1].Name}`, Icons.fromName("fluency", "outline", "mouse-cursor-click"))
		SelectCurrentGuiPluginAction.Triggered:Connect(function()
			Selection:Set({ HoveringItems[1] })
		end)
		local HideCurrentGuiPluginAction = ContextMenu:AddNewAction(tostring(math.random()), `Hide {HoveringItems[1].Name}`, Icons.fromName("fluency", "outline", "eye-invisible-dash-iris-pupil"))
		HideCurrentGuiPluginAction.Triggered:Connect(function()
			local TargetInstance = HoveringItems[1]
			TargetInstance.Visible = false
			SendToast({
				id = tostring(math.random()),
				dismissable = true,
				lifetime = false,
				Text = `Hiding "{TargetInstance:GetFullName()}", Click to undo.`,
				toastClicked = function(Id)
					TargetInstance.Visible = true
					if Id == nil then
						return nil
					end
					DismissToast(Id)
				end,
				icon = Constants.PluginDisplayIcon,
			})
		end)
		local DisableCurrentGuiPluginAction = ContextMenu:AddNewAction(tostring(math.random()), `Ignore {HoveringItems[1].Name}`)
		DisableCurrentGuiPluginAction.Triggered:Connect(function()
			local TargetInstance = HoveringItems[1]
			TargetInstance:AddTag(Tags.IgnoreHoverDetection)
			SendToast({
				id = tostring(math.random()),
				dismissable = true,
				lifetime = false,
				Text = `Ignoring "{TargetInstance:GetFullName()}", Click to undo.`,
				toastClicked = function(Id)
					TargetInstance:RemoveTag(Tags.IgnoreHoverDetection)
					if Id == nil then
						return nil
					end
					DismissToast(Id)
				end,
				icon = Constants.PluginDisplayIcon,
			})
		end)
		local SelectCurrentGuiRootScreenGui = ContextMenu:AddNewAction(tostring(math.random()), `Select Root ScreenGui For {HoveringItems[1].Name}`, Icons.fromName("fluency", "outline", "media-screen-share-broadcast"))
		SelectCurrentGuiRootScreenGui.Triggered:Connect(function()
			local RootScreenGui = HoveringItems[1]:FindFirstAncestorOfClass("ScreenGui")
			if RootScreenGui == nil then
				return nil
			end
			Selection:Set({ RootScreenGui })
		end)
		local SelectUILayerPluginMenu = GetPlugin():CreatePluginMenu(tostring(math.random()), `Select UI Layer`)
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(HoveringItem)
			SelectUILayerPluginMenu:AddNewAction(tostring(math.random()), `{HoveringItem.Name}`).Triggered:Connect(function()
				Selection:Set({ HoveringItem })
			end)
		end
		for _k, _v in HoveringItemsUnfiltered do
			_callback(_v, _k - 1, HoveringItemsUnfiltered)
		end
		-- ▲ ReadonlyArray.forEach ▲
		ContextMenu:AddMenu(SelectUILayerPluginMenu)
		local SelectAllInstancesHoveredPluginAction = ContextMenu:AddNewAction(tostring(math.random()), `Select All Hovering GUI's ({#HoveringItemsUnfiltered})`)
		SelectAllInstancesHoveredPluginAction.Triggered:Connect(function()
			Selection:Set(HoveringItemsUnfiltered)
		end)
		setRuntimeContextMenuOpened(true)
		ContextMenu:ShowAsync()
		SelectCurrentGuiPluginAction:Destroy()
		HideCurrentGuiPluginAction:Destroy()
		DisableCurrentGuiPluginAction:Destroy()
		SelectCurrentGuiRootScreenGui:Destroy()
		SelectUILayerPluginMenu:Destroy()
		SelectAllInstancesHoveredPluginAction:Destroy()
		task.delay(0.1, function()
			setRuntimeContextMenuOpened(false)
		end)
	end)
	createCleanup(function()
		RightClickListener:Disconnect()
	end)
end)
RuntimeContextMenuScope.Close()
return {
	RuntimeContextMenuOpened = RuntimeContextMenuOpened,
	setRuntimeContextMenuOpened = setRuntimeContextMenuOpened,
}
