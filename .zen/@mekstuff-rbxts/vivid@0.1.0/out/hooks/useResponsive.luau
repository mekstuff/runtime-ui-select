-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    30/05/2025 12:27:15
	
]]
local createState = TS.import(script, script.Parent.Parent, "create", "createState").createState
local _Responsive = TS.import(script, script.Parent.Parent, "internal", "Responsive")
local IsResponsiveObject = _Responsive.IsResponsiveObject
local Responsive = _Responsive.Responsive
local function useResponsive(Container)
	local ResponsiveObject = Responsive({
		sm = nil,
		container = Container,
	})
	if IsResponsiveObject(ResponsiveObject) ~= true then
		error("Did not receive ResponsiveObject from Responsive()")
	end
	local ResponsiveState, setResponsiveState, ResponsiveStateObject = createState(ResponsiveObject._group_state.State)
	ResponsiveStateObject._dev.insert(ResponsiveObject._group_state:Observe(function()
		setResponsiveState(ResponsiveObject._group_state.State)
	end, { "State" }))
	ResponsiveObject._increment_usage_total()
	ResponsiveStateObject.Destroying:Connect(function()
		ResponsiveObject._decrement_usage_total()
	end)
	return ResponsiveState, ResponsiveStateObject
end
return {
	useResponsive = useResponsive,
}
