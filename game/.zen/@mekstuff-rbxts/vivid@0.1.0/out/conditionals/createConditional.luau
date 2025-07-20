-- Compiled with roblox-ts v3.0.0-dev-d48bd20
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    02/01/2025 15:32:11
	
]]
local createEffect = TS.import(script, script.Parent.Parent, "create", "createEffect").createEffect
local createSwitch = TS.import(script, script.Parent, "createSwitch").createSwitch
local function createConditional(ConiditionFunc, createElementFunc)
	local SlotState = createEffect(function()
		local Res = ConiditionFunc()
		local _arg0 = type(Res) == "boolean"
		local _arg1 = `Expected boolean from your createConditional ConiditionFunc, got {typeof(Res)}`
		assert(_arg0, _arg1)
		return Res
	end)
	return createSwitch(SlotState, createElementFunc)
end
return {
	createConditional = createConditional,
}
