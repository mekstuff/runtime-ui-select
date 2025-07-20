-- Compiled with roblox-ts v3.0.0-dev-d48bd20
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    29/12/2024 19:52:08
	
]]
local JSX_InstanceNames = TS.import(script, script.Parent.Parent, "internal", "JSX_InstanceNames")
local _core = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "core").out)
local Servant = _core.Servant
local Spring = _core.Spring
local _typeIs = _core.typeIs
local _Nodes = TS.import(script, script.Parent.Parent, "nodes", "Nodes")
local CreateElementNode = _Nodes.CreateElementNode
local RemoveElementNode = _Nodes.RemoveElementNode
local GetElementNode = _Nodes.GetElementNode
local ClearAllEffectNodes = _Nodes.ClearAllEffectNodes
local GetEffectNode = _Nodes.GetEffectNode
local IsStatePropertyValue = TS.import(script, script.Parent, "createState").IsStatePropertyValue
local createEffect = TS.import(script, script.Parent, "createEffect").createEffect
local createEffectBoundary = TS.import(script, script.Parent, "createEffectBoundary").createEffectBoundary
local _Fragment = TS.import(script, script.Parent.Parent, "internal", "Fragment")
local _FragmentIdentifier_ = _Fragment._FragmentIdentifier_
local CreateInternalFragment = _Fragment.CreateInternalFragment
local IsInternalFragment = _Fragment.IsInternalFragment
local IsWithTransitionDef = TS.import(script, script.Parent.Parent, "internal", "WithTransition").IsWithTransitionDef
local IsVividRefObject = TS.import(script, script.Parent, "createRef").IsVividRefObject
local IsResponsiveObject = TS.import(script, script.Parent.Parent, "internal", "Responsive").IsResponsiveObject
-- e.g.Support <item>Test</item>. "Test" will be passed as the "Text" property
local InstanceClassesThatAcceptStringChildrenAsTextProp = { "TextLabel", "TextButton", "TextBox" }
local _call_withProps__index
_call_withProps__index = function(_, key, targetValue)
	local _targetValue = targetValue
	if type(_targetValue) == "function" then
		local EffectNode = GetEffectNode()
		if EffectNode ~= nil then
			-- If we try to use a prop that is a function within a createEffect, to add "reactive" behavior, we call the function and grab the results anytime we index the prop.
			-- We disable dependency injection on the createEffect while we call targetValue() as any dependency within the function should not make our createEffect rerun since we grab the value when indexed.
			-- This is for cases where we have a function component that has props that can and a "reactive function" was passed, if we attempt to use props.whateverprop inside our function component, we can.
			-- Note that the logic for passing props.reactivefunction to an actual Instance is differenty and follows the createEffect laws.
			-- TODO: We might need to change how this work since everytime prop.reactivefunction is indexed, it re-runs the function, meaning if it is a heavy function it can be very bad +
			-- it uselessly recalls the function even if the value didn't change.
			-- EffectNode.disable_dependency_injection = true;
			local Results = targetValue()
			-- EffectNode.disable_dependency_injection = false;
			return Results
		end
	end
	--
	if IsStatePropertyValue(targetValue) then
		local _callresults = targetValue._call()
		if targetValue._targetproperty ~= nil then
			-- we are targeting a property within the state. e.g. props.Property = State().Property
			local val = _callresults[targetValue._targetproperty]
			if IsStatePropertyValue(val) then
				return val
			end
			return _call_withProps__index(_, key, val)
		end
		-- normal state results, return
		if IsStatePropertyValue(_callresults) then
			return _callresults
		end
		return _call_withProps__index(_, key, _callresults)
	end
	if IsWithTransitionDef(targetValue) then
		local EffectNode = GetEffectNode()
		if EffectNode then
			-- If user attempts to use WithTransitionDef value inside of a effect, we give them the actual value.
			if IsResponsiveObject(targetValue._targetValue) then
				-- If the value is a responsive object, then run the code for IsResponsiveObject() - Code below the scope.
				return _call_withProps__index(_, key, targetValue._targetValue)
				--[[
					
									EffectNode.add_dependency(targetValue._targetValue._group_state as State<unknown>);
									const ResponsiveValue =
										targetValue._targetValue._responsive[targetValue._targetValue._group_state.State];
									return ResponsiveValue;
									
				]]
			end
			-- Note this will not be "reactive" to the spring, so essentially using it in a createEffect gives you the static value whereas passing it directly to the component props will pass the actual transition object which will make it transition work per usual.
			return targetValue._targetValue
		end
	end
	if IsResponsiveObject(targetValue) then
		local EffectNode = GetEffectNode()
		if EffectNode then
			-- If user attempts to use IsResponsiveObject value inside of a effect, we give them the actual value + add the state as a dependency of the effect
			EffectNode.add_dependency(targetValue._group_state)
			local ResponsiveValue = targetValue._responsive[targetValue._group_state.State]
			return ResponsiveValue
		end
	end
	return targetValue
end
--[[
	*
	 * @param toObject the returned object will be the Proxy version of `props`. meaning you can loop and do anything to this table like you would a normal table.
	 
]]
local function withProps(props, toObject)
	if IsStatePropertyValue(props) then
		-- Added support on 6/9/2025 - Since props in forEach can be a state if UniqueIdExtractor is defined, withProps() may be called with the state as the props, so supported was added.
		local StateValue = props._state.State
		if toObject == true then
			return if type(StateValue) == "table" then table.clone(StateValue) else StateValue
		end
		return StateValue
		-- return props // This shouldn't run I think? (withProps with a state normally should define toObject param) - NOTE: Not tested.
	end
	if getmetatable(props) ~= nil then
		return if toObject then props.__get_raw__() else props
	end
	local _propsProxy = {}
	for key, value in pairs(props) do
		_propsProxy[key] = value
		props[key] = nil
	end
	-- Returns the _propsProxy shallow copy...
	local function __get_raw__()
		return table.clone(_propsProxy)
	end
	local metatable = {
		__index = function(_, key)
			if key == "__get_raw__" then
				return __get_raw__
			end
			local targetValue = _propsProxy[key]
			return _call_withProps__index(_, key, targetValue)
		end,
		__newindex = function(_, key, value)
			_propsProxy[key] = value
		end,
		__iter = function()
			return next, _propsProxy
		end,
		__tostring = function()
			local _level = 0
			local tree = {}
			local fromArrToStr
			fromArrToStr = function(input)
				local items = {}
				_level += 1
				for a, b in pairs(input) do
					local _b = if IsStatePropertyValue(b) == true then tostring(b._state) elseif _typeIs(b, "Pseudo") ~= nil then tostring(b) elseif type(b) == "table" and _level < 3 then fromArrToStr(b) else `{b}`
					local __level = _level
					local _arg0 = `{string.rep("\t", __level)}[{a}] = {_b}`
					table.insert(items, _arg0)
				end
				local _arg0 = table.concat(items, ",\n")
				table.insert(tree, _arg0)
			end
			fromArrToStr(_propsProxy or {})
			return `vivid.props = \{\n{table.concat(tree, "\n")}\n\}`
		end,
	}
	setmetatable(props, metatable)
	return if toObject then props.__get_raw__() else props
end
local ResolveChildren
local function HandleChild(Key, Child, Parent, ParentCreateElementNode)
	if Child == nil then
		return nil
	end
	local _RootServant = ParentCreateElementNode
	if _RootServant ~= nil then
		_RootServant = _RootServant.servant
	end
	local RootServant = _RootServant
	local _child = Child
	if typeof(_child) == "Instance" then
		if Child.Name == Child.ClassName then
			-- ^ If it has the same name as the class name, override with the key.
			local _key = Key
			if type(_key) == "number" then
				Child.Name = string.format("%03d", tostring(Key))
			else
				local _key_1 = Key
				Child.Name = if type(_key_1) == "string" then Key else tostring(Key)
			end
		end
		Child.Parent = Parent
		return nil
	end
	--[[
		
			// TODO: (IMPORTANT) - Stateful Fragment children should be supported (no errors, just that the children of fragment aren't rendered in place of the state/fragment)
			e.g. code: 
		
			Attempted fix on 2/11/25, not fully tested.
			
			const [TestFragmentedState] = createState(createElement(Vivid.Fragment, undefined, createElement("Frame")));
			createElement(
				"Frame",
				{
					Parent: game.Workspace,
				},
				TestFragmentedState(),
			);
			
	]]
	if IsStatePropertyValue(Child) then
		if RootServant == nil then
			error("Stateful children require RootServant.")
		end
		RootServant:Keep(Child._state:Observe(function()
			local children = Child._state.State
			if children == nil then
				return nil
			end
			if IsStatePropertyValue(children) then
				error("Attempted to set children State value as a State.")
			end
			if IsInternalFragment(children) then
				HandleChild(Key, children, Parent, ParentCreateElementNode)
				return nil
			end
			if typeof(children) == "Instance" then
				HandleChild(Key, children, Parent, ParentCreateElementNode)
			else
				for key, child in pairs(children) do
					HandleChild(key, child, Parent, ParentCreateElementNode)
				end
			end
		end, { "State" }))
		return nil
	end
	if IsInternalFragment(Child) then
		if Child.children ~= nil then
			if Child._force_mounted == true then
				-- already mounted through other means, do not reparent to target.
				return nil
			end
			ResolveChildren(Child.children, Parent, ParentCreateElementNode)
		end
		return nil
	end
	local _child_1 = Child
	if type(_child_1) == "table" then
		-- Passed an array of children within children (in cases mostly in jsx where <element> <anotherelement/> {props.children} </element>)
		ResolveChildren(Child, Parent, ParentCreateElementNode)
		return nil
	end
	local _child_2 = Child
	if type(_child_2) == "string" then
		-- Vivid supports passing string to a textlabel and other text property elements as a child, it will file the "Text" property field of the TextLabel with the content
		-- e.g.: <textlabel>This is Text</textlabel>
		local IsSupportedTextInstance = false
		for index = 0, #InstanceClassesThatAcceptStringChildrenAsTextProp - 1 do
			local TextClass = InstanceClassesThatAcceptStringChildrenAsTextProp[index + 1]
			if Parent:IsA(TextClass) then
				IsSupportedTextInstance = true
				break
			end
		end
		local _exp = IsSupportedTextInstance
		local _exp_1 = Key
		local _exp_2 = table.concat(InstanceClassesThatAcceptStringChildrenAsTextProp, " | ")
		local _child_3 = Child
		local _arg1 = `Unexpected child received for key "{_exp_1}". Received string as input but parent element was not of class {_exp_2}. got {typeof(_child_3)} ({Child})`
		assert(_exp, _arg1)
		Parent.Text = Child
		return nil
	end
	local _exp = Key
	local _child_3 = Child
	error(`Unexpected child received for key "{_exp}". got {typeof(_child_3)} ({Child})`)
end
local function ApplyProperty(Target, key, value, ParentCreateElementNode, _allow_parent, _is_called_by_with_transition, _is_called_by_responsive)
	if key == "children" then
		return nil
	end
	if key == "Parent" and _allow_parent ~= true then
		return nil
	end
	if key == "ref" then
		local _arg0 = IsVividRefObject(value)
		local _arg1 = `value "{value}" is not a ref, could not apply ref to "{Target}"`
		assert(_arg0, _arg1)
		value._set(Target)
		return nil
	end
	if key == "forwardRef" then
		local _arg0 = IsVividRefObject(value)
		local _arg1 = `value "{value}" is not a ref, could not apply forwardRef to "{Target}"`
		assert(_arg0, _arg1)
		value._set(Target)
		return nil
	end
	if key == "tags" then
		local _value = value
		local _exp = type(_value) == "table"
		local _value_1 = value
		local _arg1 = `createElement(..., tags=...) requires tags to be an array, got {typeof(_value_1)}`
		assert(_exp, _arg1)
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(tagKey)
			Target:AddTag(tagKey)
		end
		for _k, _v in value do
			_callback(_v, _k - 1, value)
		end
		-- ▲ ReadonlyArray.forEach ▲
		return nil
	end
	if key == "attributes" then
		local _value = value
		local _exp = type(_value) == "table"
		local _value_1 = value
		local _arg1 = `createElement(..., tags=...) requires tags to be an object, got {typeof(_value_1)}`
		assert(_exp, _arg1)
		for attrKey, attrValue in pairs(value) do
			if IsStatePropertyValue(attrValue) then
				if ParentCreateElementNode == nil then
					error(`[Vivid] Attempted to use a stateful attribute value in a non functional element environment. Attempt to set "{key}" of "{Target}" to State ({attrValue})`)
				end
				-- Attribute values can be states.
				ParentCreateElementNode.servant:Keep(attrValue._state:Observe(function()
					Target:SetAttribute(attrKey, attrValue._state.State)
				end, { "State" }))
				continue
			end
			Target:SetAttribute(attrKey, attrValue)
		end
		return nil
	end
	local _value = value
	local _condition = type(_value) == "function"
	if _condition then
		local _arg0 = Target[key]
		_condition = not (type(_arg0) == "function")
	end
	if _condition then
		-- Using functions as values
		-- Using as an EventListener
		local _arg0 = Target[key]
		if typeof(_arg0) == "RBXScriptSignal" then
			Target[key]:Connect(function(...)
				local args = { ... }
				createEffectBoundary(function()
					-- TODO ^^ this effect boundary doesn't make calling the state gurantee it returns the actual .State value
					value(Target, unpack(args))
				end)
			end)
			return nil
		end
		-- Using as a createEffect
		return ApplyProperty(Target, key, createEffect(function()
			return value()
		end)(), ParentCreateElementNode, _allow_parent)
	end
	local function ApplyStateValue(Key, Value)
		local _value_1 = Value
		local _condition_1 = type(_value_1) == "function"
		if _condition_1 then
			local _arg0 = Target[Key]
			_condition_1 = not (type(_arg0) == "function")
		end
		if _condition_1 then
			-- The "Value" is a function but the Targets value isn't assume that value is a "reactive" function value, use createEffect hook.
			-- TODO: verify this doesn't cause any form of memory leaks or extra memory usage.
			return ApplyProperty(Target, Key, Value, ParentCreateElementNode, _allow_parent)
		end
		ApplyProperty(Target, Key, Value, ParentCreateElementNode, _allow_parent)
		-- (Target as unknown as Record<string, unknown>)[Key as string] = Value;
	end
	if IsStatePropertyValue(value) then
		if ParentCreateElementNode == nil then
			error(`[Vivid] Attempted to use a stateful value in a non functional element environment. Attempt to set "{key}" of "{Target}" to State ({value._state})`)
		end
		local TargetStateToObserve
		local LiveSpringEntries = value._state._dev.get("_vivid-LiveSpringEntries")
		if LiveSpringEntries == nil then
			-- normal state
			TargetStateToObserve = value._state
		else
			-- it is a spring, use the created springs to animate
			TargetStateToObserve = LiveSpringEntries[value._targetproperty]
		end
		ParentCreateElementNode.servant:Keep(TargetStateToObserve:Observe(function()
			if value._targetproperty ~= nil and LiveSpringEntries == nil then
				-- target property provided meaning it was used as a sub property. e.g. Theme().Background but `Theme` is the only State.
				-- normal state, refer to the key value within the state table itself
				ApplyStateValue(key, (TargetStateToObserve.State)[value._targetproperty])
			else
				--[[
					 REMOVED LOGIC TO USE A STATE AS A STATE, NEEDS MORE WORK IN TERMS OF CLEANING UP AND TOGGLING IF REIMPLEMENTED.
										if (typeIs(TargetStateToObserve.State, "function")) {
											// A state was used as the value, use that state instead.
											ApplyProperty(
												Target,
												key,
												() => {
													return (TargetStateToObserve.State as Callback)();
												},
												ParentCreateElementNode,
											);
											return;
										}
										
				]]
				ApplyStateValue(key, TargetStateToObserve.State)
			end
		end, { "State" }))
		return nil
	end
	-- WithTransition()'s and Responsive()'s are mapped to {[Instance] = {[Property] = [Spring]}}
	local ElementNodeConv = ParentCreateElementNode
	if IsResponsiveObject(value) then
		-- Support for Responsive(...)
		local _arg0 = ElementNodeConv and ParentCreateElementNode
		assert(_arg0, "ParentCreateElementNode is required to use Responsive()")
		ElementNodeConv._responsiveObservers = ElementNodeConv._responsiveObservers or {}
		local __responsiveObservers = ElementNodeConv._responsiveObservers
		local _target = Target
		local HasExistingInstance = __responsiveObservers[_target]
		if HasExistingInstance == nil then
			local InstanceDefRecord = {}
			local __responsiveObservers_1 = ElementNodeConv._responsiveObservers
			local _target_1 = Target
			__responsiveObservers_1[_target_1] = InstanceDefRecord
			HasExistingInstance = InstanceDefRecord
		end
		local HasExisting = HasExistingInstance[key]
		local _result = HasExisting
		if _result ~= nil then
			_result:Destroy()
		end
		ParentCreateElementNode.servant:Free(HasExisting)
		HasExistingInstance[key] = nil
		-- Apply property to target based on the state.
		local Observer = value._group_state:Observe(function()
			local ResponsiveValue = value._responsive[value._group_state.State]
			if IsWithTransitionDef(ResponsiveValue) then
				error(`Attempted to add WithTransition() to Responsive() value. "Responsive(WithTransition(...))" is unsupported, instead it should be "WithTransition(Responsive(...))"`)
			end
			if ResponsiveValue == nil then
				return nil
			end
			-- Can't call ApplyProperty since we check if there's an existing SpringObj. (5/19/2025: New argument added to support calling it)
			-- (Target as unknown as Record<string, unknown>)[key as string] = ResponsiveValue;
			ApplyProperty(Target, key, ResponsiveValue, ParentCreateElementNode, _allow_parent, false, true)
		end, { "State" })
		Observer.Destroying:Connect(function()
			value._decrement_usage_total()
		end)
		value._increment_usage_total()
		ParentCreateElementNode.servant:Keep(Observer)
		HasExistingInstance[key] = Observer
		return nil
	end
	-- Check if it previously had a Responsive() Observer Servant, If it did, Destroy it!
	local _result = ElementNodeConv
	if _result ~= nil then
		_result = _result._responsiveObservers
	end
	local _condition_1 = _result ~= nil
	if _condition_1 then
		_condition_1 = _is_called_by_responsive ~= true
	end
	if _condition_1 then
		local __responsiveObservers = ElementNodeConv._responsiveObservers
		local _target = Target
		local ExistingInstance = __responsiveObservers[_target]
		local _Existing = ExistingInstance
		if _Existing ~= nil then
			_Existing = _Existing[key]
		end
		local Existing = _Existing
		if ExistingInstance ~= nil and Existing ~= nil then
			if ParentCreateElementNode ~= nil then
				ParentCreateElementNode.servant:Free(Existing)
			end
			Existing:Destroy()
			ExistingInstance[key] = nil
			local HasContent = false
			for _element, _element_1 in pairs(ExistingInstance) do
				local v = { _element, _element_1 }
				HasContent = true
				break
			end
			if HasContent ~= true then
				local __responsiveObservers_1 = ElementNodeConv._responsiveObservers
				local _target_1 = Target
				__responsiveObservers_1[_target_1] = nil
			end
		end
	end
	if IsWithTransitionDef(value) then
		-- Support for WithTransition(...)
		local _arg0 = ElementNodeConv and ParentCreateElementNode
		assert(_arg0, "ParentCreateElementNode is required to use WithTransition()")
		ElementNodeConv._withTransitionDefs = ElementNodeConv._withTransitionDefs or {}
		local __withTransitionDefs = ElementNodeConv._withTransitionDefs
		local _target = Target
		local HasExistingInstance = __withTransitionDefs[_target]
		if HasExistingInstance == nil then
			local InstanceDefRecord = {}
			local __withTransitionDefs_1 = ElementNodeConv._withTransitionDefs
			local _target_1 = Target
			__withTransitionDefs_1[_target_1] = InstanceDefRecord
			HasExistingInstance = InstanceDefRecord
		end
		local HasExisting = HasExistingInstance[key]
		if HasExisting then
			local _condition_2 = value._damping
			if _condition_2 == nil then
				_condition_2 = HasExisting.Damping
			end
			HasExisting.Damping = _condition_2
			local _condition_3 = value._frequency
			if _condition_3 == nil then
				_condition_3 = HasExisting.Frequency
			end
			HasExisting.Frequency = _condition_3
			-- WithTransition() can accept Responsive() values. It Observes the State of the ResponsiveObject value and update the Spring to be the targetValue of the ResponsiveObject
			local _result_1 = (HasExisting._dev._responsive_observer)
			if _result_1 ~= nil then
				_result_1:Destroy()
			end
			if IsResponsiveObject(value._targetValue) then
				-- Responsive value passed into the transition. (update from one WithTransition to a next WithTransition)
				local ResponsiveObject = value._targetValue
				HasExisting._dev._responsive_observer = value._targetValue._group_state:Observe(function()
					local ResponsiveValue = ResponsiveObject._responsive[ResponsiveObject._group_state.State]
					if ResponsiveValue == nil then
						return nil
					end
					HasExisting:setState(ResponsiveValue)
				end, { "State" })
				ResponsiveObject._increment_usage_total();
				(HasExisting._dev._responsive_observer).Destroying:Connect(function()
					ResponsiveObject._decrement_usage_total()
				end)
			else
				-- Non Responsive value, Update per usual
				HasExisting:setState(value._targetValue)
			end
		else
			local _condition_2 = value._initialValue
			if _condition_2 == nil then
				_condition_2 = value._defaultValue
				if _condition_2 == nil then
					_condition_2 = Target[key]
				end
			end
			local SpringObj = Spring.new(_condition_2)
			local _condition_3 = value._damping
			if _condition_3 == nil then
				_condition_3 = SpringObj.Damping
			end
			SpringObj.Damping = _condition_3
			local _condition_4 = value._frequency
			if _condition_4 == nil then
				_condition_4 = SpringObj.Frequency
			end
			SpringObj.Frequency = _condition_4
			if IsResponsiveObject(value._targetValue) then
				-- Responsive value passed into the transition.
				local ResponsiveObject = value._targetValue
				local _result_1 = (SpringObj._dev._responsive_observer)
				if _result_1 ~= nil then
					_result_1:Destroy()
				end
				SpringObj._dev._responsive_observer = value._targetValue._group_state:Observe(function()
					local ResponsiveValue = ResponsiveObject._responsive[ResponsiveObject._group_state.State]
					if ResponsiveValue == nil then
						return nil
					end
					if value._defaultValue ~= nil then
						-- Reset to default value if defined everytime before spring transitioning
						Target[key] = value._defaultValue
						SpringObj.State = value._defaultValue
					end
					SpringObj:setState(ResponsiveValue)
				end, { "State" })
				ResponsiveObject._increment_usage_total();
				(SpringObj._dev._responsive_observer).Destroying:Connect(function()
					ResponsiveObject._decrement_usage_total()
				end)
			else
				-- Non Responsive value, Update per usual
				if value._defaultValue ~= nil then
					-- Reset to default value if defined everytime before spring transitioning
					Target[key] = value._defaultValue
					SpringObj.State = value._defaultValue
				end
				SpringObj:setState(value._targetValue)
			end
			-- Apply property to target based on the spring.
			SpringObj:Observe(function()
				-- Can't call ApplyProperty since we check if there's an existing SpringObj. (5/19/2025: New argument added to support calling it)
				-- (Target as unknown as Record<string, unknown>)[key as string] = SpringObj.State;
				ApplyProperty(Target, key, SpringObj.State, ParentCreateElementNode, _allow_parent, true, false)
			end, { "State" })
			ParentCreateElementNode.servant:Keep(SpringObj)
			HasExistingInstance[key] = SpringObj
		end
		return nil
	end
	-- Check if it previously had a WithTransitionDef, If it did, Destroy it!
	local _result_1 = ElementNodeConv
	if _result_1 ~= nil then
		_result_1 = _result_1._withTransitionDefs
	end
	local _condition_2 = _result_1 ~= nil
	if _condition_2 then
		_condition_2 = _is_called_by_with_transition ~= true
	end
	if _condition_2 then
		local __withTransitionDefs = ElementNodeConv._withTransitionDefs
		local _target = Target
		local ExistingInstance = __withTransitionDefs[_target]
		local _Existing = ExistingInstance
		if _Existing ~= nil then
			_Existing = _Existing[key]
		end
		local Existing = _Existing
		if ExistingInstance ~= nil and Existing ~= nil then
			if ParentCreateElementNode ~= nil then
				ParentCreateElementNode.servant:Free(Existing)
			end
			Existing:Destroy()
			ExistingInstance[key] = nil
			local HasContent = false
			for _element, _element_1 in pairs(ExistingInstance) do
				local v = { _element, _element_1 }
				HasContent = true
				break
			end
			if HasContent ~= true then
				local __withTransitionDefs_1 = ElementNodeConv._withTransitionDefs
				local _target_1 = Target
				__withTransitionDefs_1[_target_1] = nil
			end
		end
	end
	--[[
		
			 
	]]
	if IsInternalFragment(value) then
		value.children = Target
		return nil
	end
	Target[key] = value
end
--[[
	*
	 *
	 * Used to parent children to a Target Instance.
	 *
	 * @param targetChildren
	 * @param Target
	 * @param ParentCreateElementNode
	 
]]
function ResolveChildren(targetChildren, Target, ParentCreateElementNode)
	local children = targetChildren
	local _children = children
	local _condition = typeof(_children) == "Instance"
	if not _condition then
		_condition = IsStatePropertyValue(children) or IsInternalFragment(children)
	end
	if _condition then
		-- children will always be a table (if defined)
		children = { children }
	end
	if children ~= nil then
		for key, child in pairs(children) do
			HandleChild(key, child, Target, ParentCreateElementNode)
		end
	end
end
local function RunDismountLifecycleEventsForNode(Component, Node)
	if Node ~= nil then
		Node._dead = true
		local _result = Node.lifecycles
		if _result ~= nil then
			_result = _result.onWillDismount
		end
		if _result ~= nil then
			error("onWillDismount will not work as of now.")
		end
		local _result_1 = Node.lifecycles
		if _result_1 ~= nil then
			_result_1 = _result_1.onDismount
			if _result_1 ~= nil then
				-- ▼ ReadonlyArray.forEach ▼
				local _callback = function(cb)
					return cb(Component)
				end
				for _k, _v in _result_1 do
					_callback(_v, _k - 1, _result_1)
				end
				-- ▲ ReadonlyArray.forEach ▲
			end
		end
		local _result_2 = Node
		if _result_2 ~= nil then
			_result_2 = _result_2.lifecycles
			if _result_2 ~= nil then
				_result_2.onWillDismount = nil
			end
		end
		local _result_3 = Node
		if _result_3 ~= nil then
			_result_3 = _result_3.lifecycles
			if _result_3 ~= nil then
				_result_3.onDismount = nil
			end
		end
	end
end
local function createElement(Element, targetProps, _children_defined, ...)
	local jsx_children = { ... }
	local ParentCreateElementNode = GetElementNode()
	-- Resolve targetChildren
	-- targetChildren should always be a table. e.g. Instance -> [Instance], Fragment -> [Fragment], [Instance] -> [Instance], etc.
	-- TODO: fix -> Only jsx children are supported, named {text: createElement("Text")} is currently broken because of the check below highlighted with "****"
	--[[
		
			let targetChildren = _children_defined;
			if (typeIs(targetChildren, "table")) {
				if (IsStatePropertyValue(targetChildren) === true || IsInternalFragment(targetChildren) === true) {
					targetChildren = [targetChildren];
				}
			} else {
				targetChildren = [targetChildren];
			}
			if (targetChildren !== undefined) {
				targetChildren = [...(targetChildren as Array<Instance>), ...(jsx_children as Array<Instance>)]; // ... can be children (support for jsx markup)
			}
			
	]]
	local targetChildren = {}
	if _children_defined ~= nil then
		local __children_defined = _children_defined
		if type(__children_defined) == "table" then
			if IsStatePropertyValue(_children_defined) == true or IsInternalFragment(_children_defined) == true then
				-- is a Fragment/State
				local __children_defined_1 = _children_defined
				table.insert(targetChildren, __children_defined_1)
			else
				-- Is an array of children?
				for key, value in pairs(_children_defined) do
					targetChildren[key + 1] = value
				end
			end
		else
			local __children_defined_1 = _children_defined
			table.insert(targetChildren, __children_defined_1)
		end
	end
	for _, value in jsx_children do
		table.insert(targetChildren, value)
	end
	if Element == _FragmentIdentifier_ then
		-- createElement(createFragment)
		local _result = ParentCreateElementNode
		if _result ~= nil then
			_result = _result.servant
		end
		local _condition = _result
		if _condition == nil then
			_condition = Servant.new()
		end
		local ElementServant = _condition
		local ElementNode = CreateElementNode(ElementServant)
		local Fragment = CreateInternalFragment()
		-- if a Fragment has props, pass props to its child (only a single element can be the child of the fragment for props to be "handed" down)
		if targetProps ~= nil and targetChildren ~= nil then
			-- const _targetInstance = typeIs(targetChildren, "Instance")
			-- ? targetChildren
			-- : (targetChildren as Instance[])[0];
			Fragment._force_mounted = targetProps._force_mounted
			--eslint-disable-next-line
			for _, _targetInstance in pairs(targetChildren) do
				local _arg0 = IsInternalFragment(_targetInstance) == false
				local _arg1 = `You are adding a Fragment inside of a Fragment that is passing props to the child. e.g.\n<Portal><></></Portal>\nOR\ncreateElement(createFragment(), \{...props\}, createElement(createFragment())\})`
				assert(_arg0, _arg1)
				local _arg0_1 = typeof(_targetInstance) == "Instance"
				local _arg1_1 = `Vivid.createFragment contained "props" but "children" was not a single element or children[0] was not an Instance. Expected Instance, got {typeof(_targetInstance)}`
				assert(_arg0_1, _arg1_1)
				--[[
					
												// To control prop application for Fragments that control direct child
												const FragmentPropertyProcessor = (targetProps as Record<string, Callback>)[
													"__internal_fragment_property__processor__"
												];
												
				]]
				for a, b in pairs(targetProps) do
					--[[
						
														if (a === "__internal_fragment_property__processor__") {
															continue;
														}
														if (FragmentPropertyProcessor !== undefined) {
															FragmentPropertyProcessor({
																Key: a,
																Value: b,
																Object: _targetInstance,
																ApplyProperty: ApplyProperty,
															});
															continue;
														}
														
					]]
					if a == "_force_mounted" then
						continue
					end
					ApplyProperty(_targetInstance, a, b, nil)
				end
				local targetFragmentParent = targetProps.Parent
				if targetFragmentParent ~= nil then
					ApplyProperty(_targetInstance, "Parent", targetFragmentParent, nil, true)
					Fragment._force_mounted = true
					-- it was already mounted where it needs to be.
				end
			end
		end
		Fragment.children = targetChildren
		-- Fragments support onMount, onWillMount, onDismount, onWillDismount lifecycles, although the "will" lifecycles will not be accurate. (only supported through functions, not props)
		local _result_1 = ParentCreateElementNode
		if _result_1 ~= nil then
			_result_1 = _result_1.lifecycles
			if _result_1 ~= nil then
				_result_1 = _result_1.onWillMount
				if _result_1 ~= nil then
					-- ▼ ReadonlyArray.forEach ▼
					local _callback = function(cb)
						return cb(Fragment)
					end
					for _k, _v in _result_1 do
						_callback(_v, _k - 1, _result_1)
					end
					-- ▲ ReadonlyArray.forEach ▲
				end
			end
		end
		local _result_2 = ParentCreateElementNode
		if _result_2 ~= nil then
			_result_2 = _result_2.lifecycles
			if _result_2 ~= nil then
				_result_2 = _result_2.onMount
				if _result_2 ~= nil then
					-- ▼ ReadonlyArray.forEach ▼
					local _callback = function(cb)
						return cb(Fragment)
					end
					for _k, _v in _result_2 do
						_callback(_v, _k - 1, _result_2)
					end
					-- ▲ ReadonlyArray.forEach ▲
				end
			end
		end
		local _result_3 = ParentCreateElementNode
		if _result_3 ~= nil then
			_result_3 = _result_3.lifecycles
			if _result_3 ~= nil then
				_result_3.onMount = nil
			end
		end
		local _result_4 = ParentCreateElementNode
		if _result_4 ~= nil then
			_result_4 = _result_4.lifecycles
			if _result_4 ~= nil then
				_result_4.onWillMount = nil
			end
		end
		Fragment.Destroying:Connect(function()
			RunDismountLifecycleEventsForNode(Fragment, ParentCreateElementNode)
		end)
		RemoveElementNode(ElementNode)
		return Fragment
	end
	if IsStatePropertyValue(Element) then
		-- createElement(VividState())
		return Element
	end
	local _targetProps = targetProps
	local props = withProps(if type(_targetProps) == "table" then targetProps else {})
	local _element = Element
	local _condition = type(_element) == "table"
	if _condition then
		_condition = getmetatable(Element)
	end
	if _condition ~= 0 and _condition == _condition and _condition ~= "" and _condition then
		-- createElement() supports metatables that have a __call metamethod
		Element = (getmetatable(Element)).__call
	end
	local _element_1 = Element
	if type(_element_1) == "function" then
		-- creating element | function mode
		-- createElement(() => ...)
		local NoShallowErrorTraceback = debug.traceback()
		local CreatedInstance
		task.defer(function()
			-- We check for any yields within this functional createElement and throw an error if any.
			-- Check if any Instance was created at the end of the frame.
			if CreatedInstance == nil then
				error(`[createElement() Yield] Do you have yielding code within your createElement function? task.wait, WaitForChild, etc. cannot be used within a createElement function unless within a safe thread.\n\ntraceback:\n\n{NoShallowErrorTraceback}`)
			end
		end)
		-- passing targetChildren to props.children
		if props.children == nil then
			props.children = targetChildren
		else
			local _children = props.children
			if type(_children) == "table" then
				-- eslint-disable-next-line
				for key, value in pairs(props.children) do
					if type(key) == "number" then
						table.insert(targetChildren, value)
					else
						targetChildren[key] = value
					end
				end
				props.children = targetChildren
			end
		end
		-- props.children = props.children ?? targetChildren;
		-- props.children = targetChildren ?? props.children;
		-- if (
		-- 	typeIs(props.children, "Instance") ||
		-- 	IsStatePropertyValue(props.children) ||
		-- 	IsInternalFragment(props.children) ||
		-- 	typeIs(props.children, "table") === false
		-- ) {
		-- 	// props.children will always be a table (if defined)
		-- 	props.children = [props.children];
		-- }
		ClearAllEffectNodes()
		local FunctionElementNodeServant
		local _result = ParentCreateElementNode
		if _result ~= nil then
			_result = _result.servant
		end
		if _result ~= nil then
			-- Reuse the same Servant as the Parent ElementNode since they're all the under the same "tree".
			FunctionElementNodeServant = ParentCreateElementNode.servant
		else
			FunctionElementNodeServant = Servant.new()
		end
		local FunctionElementNode = CreateElementNode(FunctionElementNodeServant)
		CreatedInstance = Element(props)
		-- "mount"/Parent the created instance
		local _result_1 = FunctionElementNode
		if _result_1 ~= nil then
			_result_1 = _result_1.lifecycles
			if _result_1 ~= nil then
				_result_1 = _result_1.onWillMount
				if _result_1 ~= nil then
					-- ▼ ReadonlyArray.forEach ▼
					local _callback = function(cb)
						return cb(CreatedInstance)
					end
					for _k, _v in _result_1 do
						_callback(_v, _k - 1, _result_1)
					end
					-- ▲ ReadonlyArray.forEach ▲
				end
			end
		end
		if FunctionElementNode._element_mount ~= nil then
			ApplyProperty(CreatedInstance, "Parent", FunctionElementNode._element_mount, FunctionElementNode, true)
		end
		local _result_2 = FunctionElementNode
		if _result_2 ~= nil then
			_result_2 = _result_2.lifecycles
			if _result_2 ~= nil then
				_result_2 = _result_2.onMount
				if _result_2 ~= nil then
					-- ▼ ReadonlyArray.forEach ▼
					local _callback = function(cb)
						return cb(CreatedInstance)
					end
					for _k, _v in _result_2 do
						_callback(_v, _k - 1, _result_2)
					end
					-- ▲ ReadonlyArray.forEach ▲
				end
			end
		end
		if ParentCreateElementNode ~= nil then
			FunctionElementNodeServant:Keep(FunctionElementNodeServant.Destroying:Connect(function()
				RunDismountLifecycleEventsForNode(CreatedInstance, ParentCreateElementNode)
			end))
		end
		RemoveElementNode(FunctionElementNode)
		return CreatedInstance
	end
	local _element_2 = Element
	if type(_element_2) == "string" then
		-- creating element | string mode
		-- createElement("Frame")
		-- createElement("frame") --> jsx supported internally.
		local _condition_1 = JSX_InstanceNames[Element]
		if _condition_1 == nil then
			_condition_1 = Element
		end
		local CreatedInstance = Instance.new(_condition_1)
		-- Apply Properties
		local createElementPropertyProcessor = props.__internal_createElement_property__processor__
		for property, value in props do
			if property == "onMount" or property == "onWillMount" or property == "onDismount" or property == "onWillDismount" then
				if ParentCreateElementNode == nil then
					error(`Cannot use lifecycle functions outside of a functional component. "{property}" on "{Element}"`)
				end
				if property == "onMount" then
					ParentCreateElementNode.addLifeCycleEvent("onMount", value)
				end
				if property == "onWillMount" then
					ParentCreateElementNode.addLifeCycleEvent("onWillMount", value)
				end
				if property == "onDismount" then
					ParentCreateElementNode.addLifeCycleEvent("onDismount", value)
				end
				if property == "onWillDismount" then
					ParentCreateElementNode.addLifeCycleEvent("onWillDismount", value)
				end
				continue
			end
			if property == "__internal_createElement_property__processor__" then
				continue
			end
			if createElementPropertyProcessor ~= nil and property ~= "Parent" then
				local processordata = {
					Key = property,
					Value = value,
					Target = CreatedInstance,
					ApplyProperty = ApplyProperty,
					ParentCreateElementNode = ParentCreateElementNode,
				}
				createElementPropertyProcessor(processordata)
				continue
			end
			ApplyProperty(CreatedInstance, property, value, ParentCreateElementNode)
		end
		-- children
		ResolveChildren(targetChildren, CreatedInstance, ParentCreateElementNode)
		-- ResolveChildren(targetChildren ?? props.children, CreatedInstance, ParentCreateElementNode);
		-- Parent Element
		if ParentCreateElementNode == nil then
			-- Not created within a function component so we can parent it here.
			if props.Parent ~= nil then
				ApplyProperty(CreatedInstance, "Parent", props.Parent, ParentCreateElementNode, true)
			end
		else
			-- pass the target parent up to the function element node so it does the mounting
			ParentCreateElementNode._element_mount = props.Parent
		end
		local _result = ParentCreateElementNode
		if _result ~= nil then
			_result = _result.servant:Keep(CreatedInstance)
		end
		-- Detect Destroying
		local _result_1 = ParentCreateElementNode
		if _result_1 ~= nil then
			_result_1 = _result_1.servant
			if _result_1 ~= nil then
				_result_1:Keep(CreatedInstance.Destroying:Connect(function()
					ParentCreateElementNode.servant:Destroy()
				end))
			end
		end
		local _result_2 = ParentCreateElementNode
		if _result_2 ~= nil then
			_result_2 = _result_2.servant
			if _result_2 ~= nil then
				_result_2:Keep(CreatedInstance.AncestryChanged:Connect(function(_, parent)
					-- very unorthodox way for checking for destroyed.
					if parent == nil then
						ParentCreateElementNode.servant:Destroy()
					end
				end))
			end
		end
		local _result_3 = ParentCreateElementNode
		if _result_3 ~= nil then
			_result_3 = _result_3.servant
			if _result_3 ~= nil then
				_result_3:Keep(function()
					RunDismountLifecycleEventsForNode(CreatedInstance, ParentCreateElementNode)
				end)
			end
		end
		return CreatedInstance
	end
	-- Unsupported createElement call.
	local _element_3 = Element
	error(`Unsupported createElement call. Expected ClassName, JSX ClassName, Function or Fragment. Got {typeof(_element_3)} "{Element}"`)
end
--[[
	
	export function createElement0<
		E extends Callback | keyof CreatableInstances | Vivid.StatefulCallback<unknown>,
		Q extends boolean,
	>(
		Element: E,
		targetProps?: Vivid.FC.Props<E>,
		paramtargetChildren?: CreateElementChildren,
		// if true, returns the ElementNode (for JSX, this can be an extra child element).
		_private_preverve_element_node?: Q,
		...args: unknown[]
	): E extends Callback ? ReturnType<E> : E extends keyof Instances ? Instances[E] : never {
		let targetChildren: CreateElementChildren | undefined = paramtargetChildren;
	
		if (_private_preverve_element_node !== undefined && _private_preverve_element_node !== true) {
			// meaning extra children were passed (JSX support.)
			targetChildren = targetChildren ?? {};
			if (typeIs(targetChildren, "Instance")) {
				targetChildren = [targetChildren];
			}
	
			targetChildren = [
				...(targetChildren as Array<Instance>),
				_private_preverve_element_node as unknown as Instance,
				...(args as Array<Instance>),
			];
		}
	
		const ParentCreateElementNode = GetElementNode();
		// print("called createElement | Parent Node :", ParentCreateElementNode, "| Element:", Element);
	
		if (Element === (_FragmentIdentifier_ as E)) {
			const ElementServant = ParentCreateElementNode?.servant ?? new Servant();
			const ElementNode = CreateElementNode(ElementServant); // Add the element node to entry.
	
			// if a Fragment has props, pass props to its child (only a single element can be the child of the fragment for props to be "handed" down)
			if (targetProps !== undefined && targetChildren !== undefined) {
				const _targetInstance = typeIs(targetChildren, "Instance")
					? targetChildren
					: (targetChildren as Instance[])[0];
				assert(
					typeIs(_targetInstance, "Instance"),
					`Vivid.createFragment contained "props" but "children" was not a single element or children[0] was not an Instance. Expected Instance, got ${typeOf(
						_targetInstance,
					)}`,
				);
				for (const [a, b] of pairs(targetProps)) {
					ApplyProperty(_targetInstance, a as string, b, undefined);
				}
				// if (typeIs((targetProps as typeof _targetInstance).Parent, "Instance")) {
				// _targetInstance.Parent = (targetProps as typeof _targetInstance).Parent;
				ApplyProperty(_targetInstance, "Parent", (targetProps as typeof _targetInstance).Parent, undefined, true);
				// }
			}
	
			const Fragment = CreateInternalFragment();
			Fragment.children = targetChildren; // "children" of the fragment is exposed.
	
			// Fragments support onMount, onWillMount, onDismount, onWillDismount lifecycles, although the "will" lifecycles will not be accurate. (only supported through functions, not props)
			ParentCreateElementNode?.lifecycles?.onWillMount?.forEach((cb) => cb(Fragment)); // Run onWillMount lifecycles
			ParentCreateElementNode?.lifecycles?.onMount?.forEach((cb) => cb(Fragment)); // Run onWillMount lifecycles
	
			delete ParentCreateElementNode?.lifecycles?.onMount;
			delete ParentCreateElementNode?.lifecycles?.onWillMount;
	
			Fragment.Destroying.Connect(() => {
				RunDismountLifecycleEventsForNode(Fragment, ParentCreateElementNode);
			});
	
			if (_private_preverve_element_node === true) {
				return ElementNode as never;
			}
			RemoveElementNode(ElementNode);
			return Fragment as never;
		}
	
		if (IsStatePropertyValue(Element)) {
			return Element as never;
		}
	
		const props = (typeIs(targetProps, "table") ? targetProps : {}) as Record<string, unknown>;
		withProps(props);
	
		if (typeIs(Element, "string")) {
			const Target = new Instance((JSX_InstanceNames[Element] ?? Element) as keyof CreatableInstances); // createElement() supports JSX names out of the box.
			// Apply props
			for (const [key, value] of props as unknown as IterableFunction<LuaTuple<[string, unknown]>>) {
				if (key === "onMount" || key === "onWillMount" || key === "onDismount" || key === "onWillDismount") {
					if (ParentCreateElementNode === undefined) {
						throw `Cannot use lifecycle functions outside of a functional component. "${key}" on "${Element}"`;
					}
					if (key === "onMount") ParentCreateElementNode.addLifeCycleEvent("onMount", value as Callback);
					if (key === "onWillMount") ParentCreateElementNode.addLifeCycleEvent("onWillMount", value as Callback);
					if (key === "onDismount") ParentCreateElementNode.addLifeCycleEvent("onDismount", value as Callback);
					if (key === "onWillDismount")
						ParentCreateElementNode.addLifeCycleEvent("onWillDismount", value as Callback);
					continue;
				}
				ApplyProperty(Target, key as string, value, ParentCreateElementNode);
			}
	
			// children
			ResolveChildren(targetChildren ?? props.children, Target, ParentCreateElementNode);
	
			// Parent is applied after all other properties are applied.
			ParentCreateElementNode?.lifecycles?.onWillMount?.forEach((cb) => cb(Target)); // Run onWillMount lifecycles
			// if (typeIs(props.Parent, "Instance")) {
			// Target.Parent = props.Parent as Instance;
			ApplyProperty(Target, "Parent", props.Parent, ParentCreateElementNode, true);
			// }
			ParentCreateElementNode?.lifecycles?.onMount?.forEach((cb) => cb(Target)); // Run onMount lifecycles
	
			Target.Destroying.Connect(() => {
				print(
					"Detected .Destroying:",
					Target,
					"| Parent Node:",
					ParentCreateElementNode,
					"| Element Node:",
					ElementNode,
					"|",
					ParentCreateElementNode?.servant?._dev,
				);
				RunDismountLifecycleEventsForNode(Component, ParentCreateElementNode);
			});
			Target.AncestryChanged.Connect((_, parent) => {
				// very unorthodox way for checking for destroyed.
				if (parent === undefined) {
					// RunDismountLifecycleEventsForNode(Component, ParentCreateElementNode);
				}
			});
	
			delete ParentCreateElementNode?.lifecycles?.onMount;
			delete ParentCreateElementNode?.lifecycles?.onWillMount;
	
			return Target as never; // return the raw Instance if the Element is just a string.
		}
	
		let ElementServant: Servant; // If this createElement exists within another createElement, use the Servant of that createElement
		if (ParentCreateElementNode !== undefined) {
			ElementServant = ParentCreateElementNode.servant;
			if (ParentCreateElementNode._connected_cleanups !== true) {
				ParentCreateElementNode._connected_cleanups = true;
			}
			// ^^ Meaning only one root Element servant will exist "per tree"
		} else {
			ElementServant = new Servant();
		}
	
		const ElementNode = CreateElementNode(ElementServant); // Add the element node to entry.
		// print(
		// 	"created ElementNode | Created Node: ",
		// 	ElementNode,
		// 	"| Parent Node:",
		// 	ParentCreateElementNode,
		// 	"| Element:",
		// 	Element,
		// );
	
		if (ParentCreateElementNode !== undefined && ParentCreateElementNode.lifecycles !== undefined) {
			// if it is a function component, pass down the lifecycles so they get ran when the actual "string" createElement is met.
			ElementNode.lifecycles = ParentCreateElementNode.lifecycles;
		}
	
		// if it's a function, pass down children
		props.children = props.children ?? targetChildren;
		if (typeIs(props.children, "Instance") || IsStatePropertyValue(props.children)) {
			// props.children will always be a table (if defined)
			props.children = [props.children];
		}
	
		ClearAllEffectNodes(); // effects do not pass down to created elements. e.g. Root has a slot that creates a another component, the newly created component uses a state that shouldn't affect the root slot.
		const Component = Element(props); // Execute the function which should return an Instance.
	
		if (IsStatePropertyValue(Component)) {
			// using a state within createElement(...) ( used mainly by JSX )
			// ElementNode.servant.Keep(
			// 	Component._state.Observe(() => {
			// 		const TargetValue = Component._state.State;
			// 	}, ["State"]),
			// );
			return Component as never;
		}
	
		// ElementServant.Keep(Component); // Bound the Instance to the createElement Servant.
	
		/*
	
		if (IsInternalFragment(Component) || IsPlaceholderElement(Component)) {
			// Creating Fragment within function
			RemoveElementNode(ElementNode); // Clear the Element node from entry
			return Component as never;
		}
	
		function RunCleanupCode() {
			ElementNode._dead = true;
			if (ElementNode.lifecycles?.onWillDismount !== undefined) {
				throw "onWillDismount will not work as of now.";
			}
			ElementNode.lifecycles?.onDismount?.forEach((cb) => cb(Component)); // Run onWillMount lifecycles
			ElementServant.Destroy();
		}
		(Component as Instance).Destroying.Connect(RunCleanupCode);
		(Component as Instance).AncestryChanged.Connect((_, parent) => {
			if (parent === undefined) {
				// very unorthodox way for checking for destroyed.
				RunCleanupCode();
			}
		});
	
		if (
			typeIs(Component, "Instance") === false &&
			IsPlaceholderElement(Component) !== true &&
			_private_preverve_element_node !== true
		) {
			throw `Expected Instance/Fragment/Placeholder from createElement function, got ${typeOf(
				Component,
			)}. "${Component}"`;
		}
	
		function RunCleanupCode() {
			ElementNode._dead = true;
			if (ElementNode.lifecycles?.onWillDismount !== undefined) {
				throw "onWillDismount will not work as of now.";
			}
			ElementNode.lifecycles?.onDismount?.forEach((cb) => cb(Component)); // Run onWillMount lifecycles
			ElementServant.Destroy();
		}
		ElementServant.Keep(Component); // Bound the Instance to the createElement Servant.
	
		if (ParentCreateElementNode === undefined && IsPlaceholderElement(Component) !== true) {
			// It is the root component, listen to destroying events here.
			(Component as Instance).Destroying.Connect(RunCleanupCode);
			(Component as Instance).AncestryChanged.Connect((_, parent) => {
				if (parent === undefined) {
					// very unorthodox way for checking for destroyed.
					RunCleanupCode();
				}
			});
		}
	
		if (
			ConnectDismountingEvents &&
			IsPlaceholderElement(Component) !== true &&
			_private_preverve_element_node !== true
		) {
			(Component as Instance).Destroying.Connect(RunCleanupCode);
			(Component as Instance).AncestryChanged.Connect((_, parent) => {
				if (parent === undefined) {
					// very unorthodox way for checking for destroyed.
					RunCleanupCode();
				}
			});
		}
		*
	
		if (_private_preverve_element_node === true) {
			return ElementNode as never;
		}
		RemoveElementNode(ElementNode); // Clear the Element node from entry
		return Component;
	}
	
	
]]
return {
	withProps = withProps,
	ResolveChildren = ResolveChildren,
	createElement = createElement,
}
