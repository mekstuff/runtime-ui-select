-- Compiled with roblox-ts v3.0.0
local TS = require(script.Parent.Parent.Parent.include.RuntimeLib)
--[[
	
	    Typed with ❤️ @mekstuff
	    13/07/2025 20:11:59
	
]]
local Players = game:GetService("Players")
local Vivid = TS.import(script, script.Parent.Parent.Parent, "include", "node_modules", "@mekstuff-rbxts", "vivid", "out").default
local _vivid_ui = TS.import(script, script.Parent.Parent.Parent, "include", "node_modules", "@mekstuff-rbxts", "vivid-ui", "out")
local CreateDismissToastProvider = _vivid_ui.CreateDismissToastProvider
local CreateSendToastProvider = _vivid_ui.CreateSendToastProvider
local ToastsListProvider = _vivid_ui.ToastsListProvider
local Constants = TS.import(script, script.Parent.Parent.Parent, "Core", "Constants", "Constants").Constants
local SendToastProvider = CreateSendToastProvider()
local DismissToastProvider = CreateDismissToastProvider()
local function Toasts()
	local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	return Vivid.createElement("screengui", {
		Parent = PlayerGui,
		Name = `{Constants.PluginDisplayName}-Toasts`,
		DisplayOrder = Constants.ScreenGuiDisplayOrderLimit - 3,
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
	}, Vivid.createElement(ToastsListProvider, {
		sendToastProvider = SendToastProvider,
		dismissToastProvider = DismissToastProvider,
		BackgroundTransparency = 1,
		Position = UDim2.new(1, 0, 1, 0),
		AnchorPoint = Vector2.new(1, 1),
		Size = UDim2.new(0.4, 0, 1, 0),
	}))
end
local SendToast = SendToastProvider.callback
local DismissToast = DismissToastProvider.callback
return {
	Toasts = Toasts,
	SendToast = SendToast,
	DismissToast = DismissToast,
}
