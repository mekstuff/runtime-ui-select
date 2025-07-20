-- Compiled with roblox-ts v3.0.0-dev-d48bd20
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    09/02/2025 09:12:54
	
]]
local onMount = TS.import(script, script.Parent.Parent, "lifecycles", "onMount").onMount
local onWillMount = TS.import(script, script.Parent.Parent, "lifecycles", "onWillMount").onWillMount
local _createState = TS.import(script, script.Parent, "createState")
local createState = _createState.createState
local IsStatePropertyValue = _createState.IsStatePropertyValue
local onWillDismount = TS.import(script, script.Parent.Parent, "lifecycles", "onWillDismount").onWillDismount
local createElement = TS.import(script, script.Parent, "createElement").createElement
local _core = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "core").out)
local Servant = _core.Servant
local Spring = _core.Spring
local State = _core.State
local function createAnimationCall(props)
	return createElement(function()
		local _children = props.children
		local _exp = type(_children) == "function"
		local _children_1 = props.children
		local _arg1 = `function expected for createAnimation .children, got {typeof(_children_1)}`
		assert(_exp, _arg1)
		local RenderedItemPropertySprings = {}
		local StateAppliedProperties = {}
		local ApplyAllPropertiesToRenderedItem
		local RevertPropertyStates = function(LifecycleCode, UseAnimatedSpring)
			local TargetState = StateAppliedProperties[1]
			if TargetState == nil then
				-- no previous state, return to "animate" state
				if props.animate == nil and props.default == nil then
					error(`no "animate" or "default" properties defined, cannot revert.`)
				end
				ApplyAllPropertiesToRenderedItem(props.default or props.animate, `revert-props-default[{LifecycleCode}]`, UseAnimatedSpring)
			else
				ApplyAllPropertiesToRenderedItem(TargetState, `revert-props-stateful[{LifecycleCode}]`, UseAnimatedSpring)
			end
		end
		local PropertiesAsStatesObserverEntries = {}
		-- e.g. Background is a State when "initial" but Background because static when "animate", vice versa, etc. etc.
		local RenderedItem, ApplyPropertyToRenderedItem
		ApplyPropertyToRenderedItem = function(Property, Value, LifecycleCode, UseAnimatedSpring, WasUpdatedVIAInternalSpring)
			local Applied, Err = pcall(function()
				if UseAnimatedSpring == true then
					local TargetAnimatorSpring = RenderedItemPropertySprings[Property]
					if TargetAnimatorSpring == nil then
						-- TODO: (IMPORTANT!!) these springs are created outside of vivid scope/not associated with vivid, make sure to property add a cleanup
						-- create the spring with the default value of initial or the current value of the property in the rendered item.
						local _result = props.initial
						if _result ~= nil then
							_result = _result[Property]
						end
						local _condition = _result
						if _condition == nil then
							_condition = RenderedItem[Property]
						end
						local InitialValue = _condition
						local _exp_1 = if IsStatePropertyValue(InitialValue) then InitialValue._state.State else InitialValue
						local _result_1 = props.springs
						if _result_1 ~= nil then
							_result_1 = _result_1[Property]
							if _result_1 ~= nil then
								_result_1 = _result_1.damping
							end
						end
						local _condition_1 = _result_1
						if _condition_1 == nil then
							_condition_1 = 1
						end
						local _result_2 = props.springs
						if _result_2 ~= nil then
							_result_2 = _result_2[Property]
							if _result_2 ~= nil then
								_result_2 = _result_2.frequency
							end
						end
						local _condition_2 = _result_2
						if _condition_2 == nil then
							_condition_2 = 2
						end
						TargetAnimatorSpring = Spring.new(_exp_1, _condition_1, _condition_2)
						RenderedItemPropertySprings[Property] = TargetAnimatorSpring
						if IsStatePropertyValue(InitialValue) then
							-- Initially a state value
							local PreviousObserver = PropertiesAsStatesObserverEntries[Property]
							if PreviousObserver ~= nil then
								PreviousObserver:Destroy()
								PropertiesAsStatesObserverEntries[Property] = nil
							end
							PropertiesAsStatesObserverEntries[Property] = InitialValue._state:Observe(function()
								-- Map the changes of the external state to the internal state.
								TargetAnimatorSpring:setState(InitialValue._state.State)
							end, { "State" })
						end
						TargetAnimatorSpring:Observe(function()
							ApplyPropertyToRenderedItem(Property, TargetAnimatorSpring.State, LifecycleCode, false, WasUpdatedVIAInternalSpring)
						end, { "State" })
					end
					if IsStatePropertyValue(Value) then
						local PreviousObserver = PropertiesAsStatesObserverEntries[Property]
						if PreviousObserver ~= nil then
							PreviousObserver:Destroy()
							PropertiesAsStatesObserverEntries[Property] = nil
						end
						PropertiesAsStatesObserverEntries[Property] = Value._state:Observe(function()
							-- Map the changes of the external state to the internal state.
							TargetAnimatorSpring:setState(Value._state.State)
						end, { "State" })
						return nil
					end
					if WasUpdatedVIAInternalSpring == false then
						-- changed from State -> Static Value
						local PreviousObserver = PropertiesAsStatesObserverEntries[Property]
						if PreviousObserver ~= nil then
							PreviousObserver:Destroy()
							PropertiesAsStatesObserverEntries[Property] = nil
						end
					end
					TargetAnimatorSpring:setState(Value)
					return nil
				end
				RenderedItem[Property] = Value
			end)
			if Applied == false then
				local _condition = LifecycleCode
				if _condition == nil then
					_condition = "applyerr"
				end
				warn(`({_condition}) | createAnimation({RenderedItem}) failed to apply property "{Property}" because: {Err}`)
			end
		end
		ApplyAllPropertiesToRenderedItem = function(Properties, LifecycleCode, UseAnimatedSpring)
			for property, value in pairs(Properties) do
				ApplyPropertyToRenderedItem(property, value, LifecycleCode, UseAnimatedSpring)
			end
		end
		if props.initial ~= nil then
			onWillMount(function()
				-- intially props aren't animated since they will occur before mounted/visible.
				ApplyAllPropertiesToRenderedItem(props.initial, "initial-props", true)
			end)
		end
		if props.animate ~= nil or props.default then
			onMount(function()
				ApplyAllPropertiesToRenderedItem(props.animate or props.default, "animate-props", true)
			end)
		end
		if props.exit then
			onWillDismount(function()
				ApplyAllPropertiesToRenderedItem(props.exit, "exit-props", true)
			end)
		end
		-- custom defined
		if props.custom ~= nil then
			local _exp_1 = props.custom
			-- ▼ ReadonlyArray.forEach ▼
			local _callback = function(customDef)
				if #customDef._states <= 0 then
					error("Something wen't wrong, not enough state params.")
				end
				if #customDef._states == 1 then
					-- single state defined, no need to track if "all states are true"
					customDef._states[1]:Observe(function()
						local _state = customDef._states[1].State
						local _arg0 = type(_state) == "boolean"
						local _arg1_1 = `Your custom defined state was something other than a boolean: {customDef._states[1]}, got {customDef._states[1].State}`
						assert(_arg0, _arg1_1)
						if customDef._states[1].State == true then
							ApplyAllPropertiesToRenderedItem(customDef._props, "custom-defined", true)
							local __props = customDef._props
							table.insert(StateAppliedProperties, 1, __props)
							return function()
								local __props_1 = customDef._props
								local _arg0_1 = (table.find(StateAppliedProperties, __props_1) or 0) - 1
								table.remove(StateAppliedProperties, _arg0_1 + 1)
								RevertPropertyStates("custom-defined", true)
							end
						end
					end, { "State" })
				else
					-- multiple states, track when all are true
					local StatesConditionsMet = State.new(0)
					customDef._states[1]._dev.insert(StatesConditionsMet)
					local _exp_2 = customDef._states
					-- ▼ ReadonlyArray.forEach ▼
					local _callback_1 = function(state)
						state:Observe(function()
							local _state = state.State
							local _arg0 = type(_state) == "boolean"
							local _arg1_1 = `Your custom defined state was something other than a boolean: {state}, got {state.State}`
							assert(_arg0, _arg1_1)
							if state.State == true then
								StatesConditionsMet:setState(function(old)
									return old + 1
								end)
								return function()
									StatesConditionsMet:setState(function(old)
										return old - 1
									end)
								end
							end
						end, { "State" })
					end
					for _k, _v in _exp_2 do
						_callback_1(_v, _k - 1, _exp_2)
					end
					-- ▲ ReadonlyArray.forEach ▲
					-- check for all conditions being true
					local CONDITION_WAS_MET = false
					StatesConditionsMet:Observe(function()
						if StatesConditionsMet.State == #customDef._states then
							CONDITION_WAS_MET = true
							-- all conditions met
							ApplyAllPropertiesToRenderedItem(customDef._props, "custom-multi-defined", true)
							local __props = customDef._props
							table.insert(StateAppliedProperties, 1, __props)
							return nil
						end
						if StatesConditionsMet.State == 0 and CONDITION_WAS_MET == true then
							local __props = customDef._props
							local _arg0 = (table.find(StateAppliedProperties, __props) or 0) - 1
							table.remove(StateAppliedProperties, _arg0 + 1)
							RevertPropertyStates("custom-multi-defined", true)
							CONDITION_WAS_MET = false
						end
					end, { "State" })
				end
			end
			for _k, _v in _exp_1 do
				_callback(_v, _k - 1, _exp_1)
			end
			-- ▲ ReadonlyArray.forEach ▲
		end
		-- while in view
		if props.whileInView ~= nil then
			local _, setInView, InViewObject = createState(true)
			onMount(function()
				local _arg0 = RenderedItem:IsA("GuiObject")
				local _arg1_1 = `"whileInView" State for createAnimation is only available on Instances that are GuiObjects, got {RenderedItem.ClassName} ({RenderedItem})`
				assert(_arg0, _arg1_1)
				local ResolveAncestry = function() end
				local InViewServant = Servant.new()
				InViewServant:Keep(RenderedItem.AncestryChanged:Connect(function()
					ResolveAncestry()
				end))
				ResolveAncestry()
				InViewObject:Observe(function()
					if InViewObject.State == true then
						ApplyAllPropertiesToRenderedItem(props.whileInView, "inview", true)
						local _whileInView = props.whileInView
						table.insert(StateAppliedProperties, 1, _whileInView)
						return function()
							local _whileInView_1 = props.whileInView
							local _arg0_1 = (table.find(StateAppliedProperties, _whileInView_1) or 0) - 1
							table.remove(StateAppliedProperties, _arg0_1 + 1)
							RevertPropertyStates("inview", true)
						end
					end
				end, { "State" })
			end)
		end
		-- while hovering
		if props.whileHovering ~= nil then
			local _, setHoveringState, HoveringStateObject = createState(false)
			onMount(function()
				local _arg0 = RenderedItem:IsA("GuiObject")
				local _arg1_1 = `"whileHovering" State for createAnimation is only available on Instances that are GuiObjects, got {RenderedItem.ClassName} ({RenderedItem})`
				assert(_arg0, _arg1_1)
				RenderedItem.MouseEnter:Connect(function()
					setHoveringState(true)
				end)
				RenderedItem.MouseLeave:Connect(function()
					setHoveringState(false)
				end)
				HoveringStateObject:Observe(function()
					if HoveringStateObject.State == true then
						ApplyAllPropertiesToRenderedItem(props.whileHovering, "state-hovering", true)
						local _whileHovering = props.whileHovering
						table.insert(StateAppliedProperties, 1, _whileHovering)
						return function()
							local _whileHovering_1 = props.whileHovering
							local _arg0_1 = (table.find(StateAppliedProperties, _whileHovering_1) or 0) - 1
							table.remove(StateAppliedProperties, _arg0_1 + 1)
							RevertPropertyStates("state-hovering", true)
						end
					end
				end, { "State" })
			end)
		end
		-- while click
		if props.whileClicking ~= nil then
			local _, setClickingState, ClickingStateObject = createState(false)
			-- if (props.animate === undefined) {
			-- 	warn(
			-- 		"props.whileClicking is defined but no props.animate was defined. meaning state will not revert, this may be a mistake.",
			-- 	);
			-- }
			onMount(function()
				local _arg0 = RenderedItem:IsA("GuiButton")
				local _arg1_1 = `"whileClicking" State for createAnimation is only available on Instances that are GuiButton, got {RenderedItem.ClassName} ({RenderedItem})`
				assert(_arg0, _arg1_1)
				RenderedItem.MouseButton1Down:Connect(function()
					setClickingState(true)
				end)
				RenderedItem.MouseButton1Up:Connect(function()
					setClickingState(false)
				end)
				ClickingStateObject:Observe(function()
					if ClickingStateObject.State == true then
						ApplyAllPropertiesToRenderedItem(props.whileClicking, "state-clicking", true)
						local _whileClicking = props.whileClicking
						table.insert(StateAppliedProperties, 1, _whileClicking)
						return function()
							local _whileClicking_1 = props.whileClicking
							local _arg0_1 = (table.find(StateAppliedProperties, _whileClicking_1) or 0) - 1
							table.remove(StateAppliedProperties, _arg0_1 + 1)
							RevertPropertyStates("state-clicking", true)
						end
					end
				end, { "State" })
			end)
		end
		RenderedItem = props.children()
		--[[
			
					// use property processor if transitions are enabled
						props.transition
							? {
									["__internal_createElement_property__processor__"]: (
										data: Vivid.createElementPropertyProcessorProps,
									) => {
										const transitions = props.transition!;
										const propIsAnimated = transitions[data.Key];
										if (propIsAnimated === undefined) {
											data.ApplyProperty(data.Target, data.Key, data.Value, data.ParentCreateElementNode);
											return;
										}
										const [StateAnimator, setStateAnimator] = createState(
											(data.Target as unknown as Record<string, unknown>)[data.Key],
										);
			
										data.ApplyProperty(data.Target, data.Key, StateAnimator(), data.ParentCreateElementNode);
									},
							  }
							: undefined,
							
		]]
		local _arg0 = typeof(RenderedItem) == "Instance"
		local _arg1_1 = `expected single Instance from createAnimation .children function, got {typeof(RenderedItem)}`
		assert(_arg0, _arg1_1)
		return RenderedItem
	end)
end
local define_custom_animation_state = function(StateConditions, Props)
	local TargetStates = {}
	if IsStatePropertyValue(StateConditions) then
		local __state = StateConditions._state
		table.insert(TargetStates, __state)
	else
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(StateCondition)
			if IsStatePropertyValue(StateCondition) ~= true then
				error(`Condition {StateCondition} is not a StatePropertyValue. Make sure you're calling the State and not passing a boolean value.`)
			end
			local __state = StateCondition._state
			table.insert(TargetStates, __state)
		end
		for _k, _v in StateConditions do
			_callback(_v, _k - 1, StateConditions)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	local _props = Props
	local _arg0 = type(_props) == "table"
	local _arg1 = `Props {Props} is not a table.`
	assert(_arg0, _arg1)
	return {
		_props = Props,
		_states = TargetStates,
	}
end
local createAnimation = setmetatable({
	custom = define_custom_animation_state,
}, {
	__call = function(tprops)
		local props = tprops
		local _children = props.children
		if type(_children) == "table" then
			props.children = props.children[1]
		end
		-- since we directly call __call, this is not the first param.
		-- View createElement.ts for this __call
		return createAnimationCall(props)
	end,
})
return {
	createAnimation = createAnimation,
}
