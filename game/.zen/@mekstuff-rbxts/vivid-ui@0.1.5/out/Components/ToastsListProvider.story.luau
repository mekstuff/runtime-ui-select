-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    29/05/2025 21:19:03
	
]]
local Vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out).default
local CreateStory = TS.import(script, script.Parent.Parent, "Utils", "CreateStory").CreateStory
local Label = TS.import(script, script.Parent, "Base").Label
local Controls = {}
return CreateStory(Controls, function(props)
	-- const SendToastProvider = CreateSendToastProvider();
	-- const DismissToastProvider = CreateDismissToastProvider();
	-- task.delay(1, () => {
	-- 	SendToastProvider.callback({
	-- 		Text: "This was sent using a ToastProvider callback.",
	-- 	});
	-- });
	-- return <ToastsListProvider sendToastProvider={SendToastProvider} dismissToastProvider={DismissToastProvider} />;
	return Vivid.createElement(Label, {
		Text = "ToastListProvider is a runtime only component.",
	})
end)
