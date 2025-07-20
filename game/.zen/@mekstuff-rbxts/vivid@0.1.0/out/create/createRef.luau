-- Compiled with roblox-ts v3.0.0-dev-d48bd20
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    08/02/2025 23:01:17
	
]]
local GetEffectNode = TS.import(script, script.Parent.Parent, "nodes", "Nodes").GetEffectNode
local use = TS.import(script, script.Parent.Parent, "use", "use").use
local createState = TS.import(script, script.Parent, "createState").createState
local function IsVividRefObject(input)
	local _input = input
	local _condition = type(_input) == "table"
	if _condition then
		_condition = input._is_vivid_ref == true
	end
	if _condition then
		return true
	end
	return false
end
--[[
	*
	 * NonNullable generic should only be used if you're certain you'll only call the Ref within a safe lifecycle. e.g.: onMount.
	 
]]
local function createRef()
	local Ref, setRef = createState(nil)
	return setmetatable({
		_is_vivid_ref = true,
		_set = function(value)
			setRef(value)
		end,
	}, {
		__call = function()
			if GetEffectNode() then
				return Ref()
			end
			return use(function()
				return Ref()
			end)
		end,
	})
end
return {
	IsVividRefObject = IsVividRefObject,
	createRef = createRef,
}
