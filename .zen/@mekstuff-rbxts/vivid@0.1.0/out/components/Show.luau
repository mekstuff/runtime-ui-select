-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local createSwitch = TS.import(script, script.Parent.Parent, "conditionals", "createSwitch").createSwitch
local CreateElementFragmentRenderFunction = TS.import(script, script.Parent.Parent, "create", "createElement").CreateElementFragmentRenderFunction
local createEffect = TS.import(script, script.Parent.Parent, "create", "createEffect").createEffect
local function Show(props)
	local SlotState = createEffect(function()
		local _condition = props.condition
		local _result
		if type(_condition) == "boolean" then
			_result = props.condition
		else
			local _condition_1 = props.condition
			_result = if type(_condition_1) == "function" then props.condition() else props.condition()
		end
		local res = _result
		return res
	end)
	return createSwitch(SlotState()).Case(true, props.children).Case(false, CreateElementFragmentRenderFunction)
end
return {
	Show = Show,
}
