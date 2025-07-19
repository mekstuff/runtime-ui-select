-- Compiled with roblox-ts v3.0.0-dev-d48bd20
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    30/12/2024 14:56:06
	
]]
local _core = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "core").out)
local Spring = _core.Spring
local State = _core.State
local _Nodes = TS.import(script, script.Parent.Parent, "nodes", "Nodes")
local GetEffectNode = _Nodes.GetEffectNode
local GetElementNode = _Nodes.GetElementNode
local GetlifecycleNode = _Nodes.GetlifecycleNode
local createScope = TS.import(script, script.Parent, "createScope").createScope
local function IsStatePropertyValue(Input)
	local _input = Input
	if not (type(_input) == "table") then
		return false
	end
	if Input._isstatepropval == true then
		return true
	end
	return false
end
--[[
	*
	 * @param CallState Will immediately () Call the state within its scope, this should be used if you're passing the State as a prop to a Vivid Component but you're outside of an Element or Scope.
	 
]]
--[[
	*
	 * Create a Vivid State from a Pseudo State or Pseudo Spring.
	 
]]
local createState
local function createStateFrom(From, CallState)
	local fromStateScope
	if GetElementNode() == nil then
		-- If not called in a Scope/ElementNode, Create a Scope then Close it after state is created.
		fromStateScope = createScope()
	end
	-- Creating Vivid State from a Pseudo ObserveListener
	local _from = From
	local _condition = type(_from) == "table"
	if _condition then
		_condition = From._pseudo ~= nil
	end
	if _condition then
		local ObserveListenerObj = From
		local __deps = ObserveListenerObj._deps
		local _arg0 = type(__deps) == "table"
		assert(_arg0, "ObserverListener for createStateFrom requires dependency to be defined")
		local _arg0_1 = #ObserveListenerObj._deps == 1
		local _arg1 = `ObserverListener for createStateFrom requires dependencyies array to have only 1 entry, got {#ObserveListenerObj._deps}`
		assert(_arg0_1, _arg1)
		local TargetProp = ObserveListenerObj._deps[1]
		local _arg0_2 = TargetProp ~= nil
		assert(_arg0_2, "ObserverListener for createStateFrom requires dependencyies array to have only 1 entry")
		local CreatedVividState, setCreatedVividState, CreatedVividStateObj = createState(ObserveListenerObj._pseudo[TargetProp])
		CreatedVividStateObj._dev.insert(ObserveListenerObj._pseudo:Observe(function()
			setCreatedVividState(ObserveListenerObj._pseudo[TargetProp])
		end, ObserveListenerObj._deps))
		if CallState == true then
			local _fromStateScope = fromStateScope
			assert(_fromStateScope, "Attempted to CallState() for createStateFrom but no Scope was created. If you're calling createStateFrom() inside an Element or Scope, you should not pass the `CallState?: boolean` argument.")
			local Value = CreatedVividState()
			fromStateScope.Close()
			ObserveListenerObj._pseudo._dev.insert(fromStateScope)
			return Value
		end
		if fromStateScope ~= nil then
			fromStateScope.Servant:Keep(CreatedVividStateObj)
			fromStateScope.Close()
			ObserveListenerObj._pseudo._dev.insert(fromStateScope)
		end
		return CreatedVividState
	end
	-- Creating Vivid State from a State/Spring
	local State = From
	local CreatedVividState, setCreatedVividState, CreatedVividStateObj = createState(State.State)
	CreatedVividStateObj._dev.insert(State:ObserveNext(function()
		setCreatedVividState(State.State)
	end, { "State" }))
	if CallState == true then
		local _fromStateScope = fromStateScope
		assert(_fromStateScope, "Attempted to CallState() for createStateFrom but no Scope was created. If you're calling createStateFrom() inside an Element or Scope, you should not pass the `CallState?: boolean` argument.")
		local Value = CreatedVividState()
		fromStateScope.Close()
		State._dev.insert(CreatedVividStateObj)
		return Value
	end
	if fromStateScope ~= nil then
		fromStateScope.Close()
		State._dev.insert(CreatedVividStateObj)
	end
	return CreatedVividState
end
function createState(defaultValue, _internal_spring)
	local StateObj
	if _internal_spring == nil then
		StateObj = State.new(defaultValue)
	else
		StateObj = Spring.new(defaultValue, _internal_spring.damping, _internal_spring.frequency)
	end
	local ElementNode = GetElementNode()
	if ElementNode == nil then
		error(`Attempted to createState({defaultValue}) outside of an Element or a Scope.`)
	end
	ElementNode.servant:Keep(StateObj)
	local SPV
	local vState
	local function GetSPV()
		if SPV ~= nil then
			return SPV
		end
		local newSPV = {
			_isstatepropval = true,
			_state = StateObj,
			_call = vState,
		}
		return setmetatable(newSPV, {
			__tostring = function()
				return `vivid.state=({StateObj:GetIdAsync()})`
			end,
			__index = function(_, key)
				if key == "_targetproperty" then
					return nil
				end
				if key == "_dev" then
					return nil
				end
				local WasIndexedInEffectNode = GetEffectNode()
				if WasIndexedInEffectNode ~= nil then
					-- used in forEach where uniqueId is defined and "props" become a state.
					return (vState())[key]
				end
				-- using a sub property of the SPV. for e.g. Theme().Background
				local _state = StateObj.State
				local _condition = not (type(_state) == "table")
				if not _condition then
					_condition = IsStatePropertyValue(StateObj.State)
				end
				if _condition then
					local IsCompatiableValue, IsCompatiableValueResults = pcall(function()
						return (StateObj.State)[key]
					end)
					if IsCompatiableValue == true then
						return IsCompatiableValueResults
					end
					error(`Attempting to index a State or non table value of a State value. The State Value of the State must be a table to allow indexing. Attempted "{key}" on: {StateObj.State}`)
				end
				local subSPV = {
					_isstatepropval = true,
					_state = StateObj,
					_call = vState,
					_targetproperty = key,
				}
				return subSPV
			end,
		})
	end
	vState = function()
		-- call the state
		local EffectNode = GetEffectNode()
		-- print(EffectNode, StateObj.State);
		if EffectNode ~= nil then
			-- Called within a createEffect
			-- if (EffectNode.effect_boundaries !== undefined) {
			-- 	// it has an effect boundary attached,
			-- 	print("attached");
			-- }
			-- if it is called within a createEffect, add state as a dependency
			EffectNode.add_dependency(StateObj)
			return StateObj.State
		end
		local LifecycleNode = GetlifecycleNode()
		if LifecycleNode ~= nil then
			-- calling State within a lifecycle just returns the value.
			return StateObj.State
		end
		local CalledElementNode = GetElementNode()
		if CalledElementNode then
			-- It is used within an ElementNode and the current node is the current element node, so we return the state as a property.
			return GetSPV()
		end
		return StateObj.State
	end
	local vSetState = function(arg0)
		-- set the state
		return StateObj:setState(arg0)
	end
	return vState, vSetState, StateObj
end
return {
	IsStatePropertyValue = IsStatePropertyValue,
	createStateFrom = createStateFrom,
	createState = createState,
}
