-- Compiled with roblox-ts v3.0.0-dev-d48bd20
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    02/01/2025 00:09:33
	
]]
local Spring = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "core").out).Spring
local createState = TS.import(script, script.Parent, "createState").createState
local function createSpring(defaultValue, damping, frequency)
	if damping == nil then
		damping = 1
	end
	if frequency == nil then
		frequency = 1
	end
	local CallFunc, SetFunc, SpringState = createState(defaultValue, {
		damping = damping,
		frequency = frequency,
	})
	local OldKeyValuesForArr = {}
	local LiveEntriesListForArr = {}
	local _state = SpringState.State
	if type(_state) == "table" then
		for key, value in pairs(SpringState.State) do
			OldKeyValuesForArr[key] = value
			local UpdateSpring = Spring.new(value)
			UpdateSpring.Damping = SpringState.Damping
			UpdateSpring.Frequency = SpringState.Frequency
			LiveEntriesListForArr[key] = UpdateSpring
		end
		SpringState._dev.set("_vivid-LiveSpringEntries", LiveEntriesListForArr)
	end
	local ResolveCustomSetFuncValue = function(input)
		local _input = input
		if type(_input) == "function" then
			return input(SpringState.State)
		end
		return input
	end
	local CustomSetFunc = function(arg)
		local _state_1 = SpringState.State
		if type(_state_1) == "table" then
			-- Updating the spring as a table.
			local Values = ResolveCustomSetFuncValue(arg)
			if type(Values) == "table" ~= true then
				error(`Spring cannot convert from table to "{typeof(Values)}"`)
			end
			for key, value in pairs(Values) do
				local PreviousValue = OldKeyValuesForArr[key]
				if PreviousValue == nil then
					error(`Spring cannot update "{key}" found in dictionary as the previous value is unknown.`)
				end
				if value == PreviousValue then
					continue
				end
				OldKeyValuesForArr[key] = value
				if LiveEntriesListForArr[key] then
					local Existing = LiveEntriesListForArr[key]
					Existing:setState(value)
					continue
				end
				error(`"{key}" was not updated by Spring as it was not found in the LiveEntries List!`)
			end
			SpringState.State = Values
			-- SetFunc(arg as never);
		else
			SetFunc(arg)
		end
	end
	return CallFunc, CustomSetFunc, SpringState
end
return {
	createSpring = createSpring,
}
