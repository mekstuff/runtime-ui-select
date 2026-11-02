-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    27/06/2026 12:23:40
	
]]
local RunService = game:GetService("RunService")
local onMount = TS.import(script, script.Parent.Parent, "lifecycles", "onMount").onMount
local onWillMount = TS.import(script, script.Parent.Parent, "lifecycles", "onWillMount").onWillMount
local onWillDismount = TS.import(script, script.Parent.Parent, "lifecycles", "onWillDismount").onWillDismount
local _core = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "core").out)
local Spring = _core.Spring
local State = _core.State
local createState = TS.import(script, script.Parent.Parent, "create", "createState").createState
local createEffect = TS.import(script, script.Parent.Parent, "create", "createEffect").createEffect
local GetElementNode = TS.import(script, script.Parent.Parent, "nodes", "Nodes").GetElementNode
local TweenService = game:GetService("TweenService")
local EMPTYOBJECT = {}
-- default - Will always use these property values if non is found in the current state.
-- initial - Will use these property values whenever the component is about to be mounted.
-- animate - Will use these property values whenever the component has mounted.
-- dismount - Will use these property values whenever the component is about to be dismounted.
-- whileHovered - Will use these property values whenever the component is being hovered (GuiObject's only).
-- whileClicked - Will use these property values whenever the component is being clicked (GuiObject's only).
-- type MotionDefValue<T extends object = {}> = {
-- 	[k in keyof T]?:
-- 		| T[k]
-- 		| {
-- 				value: T[k];
-- 				config?: MotionDefConfig;
-- 		  };
-- };
local INVIEW_STATES_MAP = {}
local INVIEW_STATE_UPDATE_CONNECTION_INTERVAL = 0.5
local INVIEW_STATE_UPDATE_CONNECTION = nil
local function GetIsGuiObjectWithinBounds(GuiObject, Bounds, BoundsPosition)
	local _exp = GuiObject.AbsolutePosition.X + GuiObject.AbsoluteSize.X
	local _result = BoundsPosition
	if _result ~= nil then
		_result = _result.X
	end
	local _condition = _result
	if _condition == nil then
		_condition = 0
	end
	if _exp < _condition then
		-- offscreen on the left
		return false
	end
	if GuiObject.AbsolutePosition.X > Bounds.X then
		-- offscreen on the right
		return false
	end
	local _exp_1 = GuiObject.AbsolutePosition.Y + GuiObject.AbsoluteSize.Y
	local _result_1 = BoundsPosition
	if _result_1 ~= nil then
		_result_1 = _result_1.X
	end
	local _condition_1 = _result_1
	if _condition_1 == nil then
		_condition_1 = 0
	end
	if _exp_1 < _condition_1 then
		-- offscreen on the left
		return false
	end
	if GuiObject.AbsolutePosition.Y > Bounds.Y then
		-- offscreen on the bottom
		return false
	end
	return true
end
local function ListenForInViewStates()
	if INVIEW_STATE_UPDATE_CONNECTION ~= nil then
		return nil
	end
	local lastUpdate = tick() - INVIEW_STATE_UPDATE_CONNECTION_INTERVAL
	INVIEW_STATE_UPDATE_CONNECTION = RunService.Heartbeat:Connect(function(dt)
		local timeNow = tick()
		if timeNow - lastUpdate - dt < INVIEW_STATE_UPDATE_CONNECTION_INTERVAL then
			return nil
		end
		lastUpdate = timeNow
		-- ▼ ReadonlyMap.size ▼
		local _size = 0
		for _ in INVIEW_STATES_MAP do
			_size += 1
		end
		-- ▲ ReadonlyMap.size ▲
		if _size == 0 then
			local _result = INVIEW_STATE_UPDATE_CONNECTION
			if _result ~= nil then
				_result:Disconnect()
			end
			INVIEW_STATE_UPDATE_CONNECTION = nil
			return nil
		end
		local _viewportSize = game.Workspace.CurrentCamera
		if _viewportSize ~= nil then
			_viewportSize = _viewportSize.ViewportSize
		end
		local viewportSize = _viewportSize
		-- ▼ ReadonlyMap.forEach ▼
		local _callback = function(state, instance)
			local scrollingFrameAncestor = instance:FindFirstAncestorWhichIsA("ScrollingFrame")
			local targetViewportSize = if scrollingFrameAncestor then scrollingFrameAncestor.AbsoluteSize else viewportSize
			if targetViewportSize == nil then
				return nil
			end
			local isInView = GetIsGuiObjectWithinBounds(instance, targetViewportSize, if scrollingFrameAncestor then scrollingFrameAncestor.AbsolutePosition else nil)
			state:SetState(isInView)
		end
		for _k, _v in INVIEW_STATES_MAP do
			_callback(_v, _k, INVIEW_STATES_MAP)
		end
		-- ▲ ReadonlyMap.forEach ▲
	end)
end
local function AddInViewState(Instance, State)
	local _instance = Instance
	local _state = State
	INVIEW_STATES_MAP[_instance] = _state
	ListenForInViewStates()
end
local function RemoveInViewState(Instance)
	local _instance = Instance
	INVIEW_STATES_MAP[_instance] = nil
end
local function GetPropertiesFromMotionDef(MotionDefValue)
	local _motionDefValue = MotionDefValue
	if type(_motionDefValue) == "function" then
		return MotionDefValue()
	end
	return MotionDefValue
end
local function GetMotionPropertyValueInfo(MotionPropertyValue, DefaultConfig)
	local _motionPropertyValue = MotionPropertyValue
	if type(_motionPropertyValue) == "table" then
		return {
			value = MotionPropertyValue.value,
			config = MotionPropertyValue.config or DefaultConfig,
		}
	end
	return {
		value = MotionPropertyValue,
		config = DefaultConfig,
	}
end
local function ApplyMotionProperties(Instance, MotionProperties, MotionInfo, ConfigInfo, UpdateMotionStateValue, SubLevel, TargetActiveKeys)
	local instanceAny = Instance
	local tweenMotionsList = nil
	local instanceChildren = Instance:GetChildren()
	local ActiveKeys = if SubLevel == nil then {} else (TargetActiveKeys or {})
	-- const ActiveKeys: string[] = [];
	for key, value in pairs(MotionProperties) do
		-- child selector e.g. ".childName"
		local matchChildNameSelector = (string.match(key, "^%.(.+)"))
		if matchChildNameSelector ~= nil then
			for _, child in instanceChildren do
				if child.Name ~= matchChildNameSelector then
					continue
				end
				ApplyMotionProperties(child, GetPropertiesFromMotionDef(value), MotionInfo, ConfigInfo, UpdateMotionStateValue, if SubLevel ~= 0 and SubLevel == SubLevel and SubLevel then SubLevel + 1 else 1, ActiveKeys)
			end
			continue
		end
		-- child class name selector e.g. "#className"
		local matchChildClassNameSelector = (string.match(key, "^#(.+)"))
		if matchChildClassNameSelector ~= nil then
			for _, child in instanceChildren do
				if not child:IsA(matchChildClassNameSelector) then
					continue
				end
				ApplyMotionProperties(child, GetPropertiesFromMotionDef(value), MotionInfo, ConfigInfo, UpdateMotionStateValue, if SubLevel ~= 0 and SubLevel == SubLevel and SubLevel then SubLevel + 1 else 1, ActiveKeys)
			end
			continue
		end
		local SubLevelKey = if SubLevel ~= 0 and SubLevel == SubLevel and SubLevel then `{SubLevel}_{key}` else key
		if (table.find(ActiveKeys, SubLevelKey) or 0) - 1 == -1 then
			table.insert(ActiveKeys, SubLevelKey)
		end
		local PropertyValueInfo = GetMotionPropertyValueInfo(value, ConfigInfo)
		local isReadonly = if PropertyValueInfo.config.readonly ~= nil then PropertyValueInfo.config.readonly else ConfigInfo.readonly
		local isStatic = MotionInfo.Static == true or PropertyValueInfo.config.type == "static" or ConfigInfo.type == "static"
		local isSpring = PropertyValueInfo.config.type == "spring" or ConfigInfo.type == "spring"
		local isTween = PropertyValueInfo.config.type == nil or PropertyValueInfo.config.type == "tween" or ConfigInfo.type == nil or ConfigInfo.type == "tween"
		-- Static
		if isStatic then
			-- CleanupSpringControlledProperty(MotionInfo.SpringControlled, SubLevelKey);
			if isReadonly ~= true then
				instanceAny[key] = PropertyValueInfo.value
			end
			if SubLevel == nil then
				UpdateMotionStateValue(key, PropertyValueInfo.value)
			end
			continue
		end
		-- Spring
		if isSpring then
			local targetSpring = MotionInfo.SpringControlled[SubLevelKey]
			if targetSpring == nil then
				targetSpring = Spring.new(if isReadonly then PropertyValueInfo.value else instanceAny[key])
				local targetSpringRecord = targetSpring
				targetSpringRecord._controlledInstances = {}
				MotionInfo.SpringControlled[SubLevelKey] = targetSpring
				targetSpring:Observe(function()
					if isReadonly ~= true then
						local _result = targetSpringRecord._controlledInstances
						if _result ~= nil then
							-- ▼ ReadonlyArray.forEach ▼
							local _callback = function(controlledInstance)
								controlledInstance[key] = targetSpring.State
							end
							for _k, _v in _result do
								_callback(_v, _k - 1, _result)
							end
							-- ▲ ReadonlyArray.forEach ▲
						end
					end
					if SubLevel == nil then
						UpdateMotionStateValue(key, targetSpring.State)
					end
				end, { "State" })
			end
			local targetSpringRecord = targetSpring
			local __controlledInstances = targetSpringRecord._controlledInstances
			local _instance = Instance
			if (table.find(__controlledInstances, _instance) or 0) - 1 == -1 then
				local _result = targetSpringRecord._controlledInstances
				if _result ~= nil then
					local _instance_1 = Instance
					table.insert(_result, _instance_1)
				end
			end
			local _condition = PropertyValueInfo.config.damping
			if _condition == nil then
				_condition = ConfigInfo.damping
				if _condition == nil then
					_condition = targetSpring.Damping
				end
			end
			targetSpring.Damping = _condition
			local _condition_1 = PropertyValueInfo.config.frequency
			if _condition_1 == nil then
				_condition_1 = ConfigInfo.frequency
				if _condition_1 == nil then
					_condition_1 = targetSpring.Frequency
				end
			end
			targetSpring.Frequency = _condition_1
			targetSpring:SetGoal(PropertyValueInfo.value)
			continue
		end
		-- Tween
		if isTween then
			-- CleanupSpringControlledProperty(MotionInfo.SpringControlled, SubLevelKey);
			if SubLevel == nil then
				UpdateMotionStateValue(key, PropertyValueInfo.value)
			end
			if isReadonly ~= true then
				tweenMotionsList = tweenMotionsList or {}
				tweenMotionsList[key] = PropertyValueInfo.value
			end
		end
	end
	for key, spring in pairs(MotionInfo.SpringControlled) do
		if (table.find(ActiveKeys, key) or 0) - 1 > -1 then
			continue
		end
		spring:Destroy()
		MotionInfo.SpringControlled[key] = nil
	end
	if tweenMotionsList ~= nil then
		local tween = TweenService:Create(Instance, TweenInfo.new(1), tweenMotionsList)
		-- tween.Play();
	end
end
--[[
	*
	 * Animate components easily.
	 
]]
local function Motion(motion, config)
	local motionElementNode = GetElementNode()
	local _arg1 = `Attempted to call Motion with Element Node, expected to be created within a render function.`
	assert(motionElementNode, _arg1)
	local motionConfig = config or {}
	local defaultMotionValues = {}
	local motionDef = {}
	local motionState, _, motionStateObject = createState({})
	local motionStates, __, motionStatesObject = createState({
		clicked = false,
		hovered = false,
		inView = false,
	})
	local springControlledMotions = motionElementNode._spring_controlled_motions or {}
	motionElementNode._spring_controlled_motions = springControlledMotions
	local BulkUpdateMotionStateRecord = {}
	local AwaitingBulkUpdateMotionState = false
	local BulkUpdateMotionStateValueRecord = {}
	local AwaitingBulkUpdateMotionStateValue = false
	local UpdateMotionStateBulk = function(key, value)
		BulkUpdateMotionStateRecord[key] = value
		if AwaitingBulkUpdateMotionState then
			return nil
		end
		AwaitingBulkUpdateMotionState = true
		task.delay(0, function()
			for bulkKey, bulkValue in pairs(BulkUpdateMotionStateRecord) do
				(motionStatesObject.State)[bulkKey] = bulkValue
			end
			motionStatesObject:useNewIndexAssignment("State", motionStatesObject.State)
			table.clear(BulkUpdateMotionStateRecord)
			AwaitingBulkUpdateMotionState = false
		end)
	end
	local UpdateMotionStateValue = function(key, value)
		BulkUpdateMotionStateValueRecord[key] = value
		if AwaitingBulkUpdateMotionStateValue then
			return nil
		end
		AwaitingBulkUpdateMotionStateValue = true
		task.delay(0, function()
			for bulkKey, bulkValue in pairs(BulkUpdateMotionStateValueRecord) do
				(motionStateObject.State)[bulkKey] = bulkValue
			end
			motionStateObject:useNewIndexAssignment("State", motionStateObject.State)
			table.clear(BulkUpdateMotionStateValueRecord)
			AwaitingBulkUpdateMotionStateValue = false
		end)
	end
	local mb1downState = nil
	local hoveringState = nil
	local inViewState = nil
	local currentReactiveState = nil
	local getInViewProperties = function()
		local _result = inViewState
		if _result ~= nil then
			_result = _result.State
		end
		local _result_1
		if _result == true then
			local _condition = motionDef.whileInView
			if _condition == nil then
				_condition = EMPTYOBJECT
			end
			_result_1 = _condition
		else
			_result_1 = EMPTYOBJECT
		end
		return _result_1
	end
	local getDefaultORInitialValues = function()
		local _condition = motionDef.initial
		if _condition == nil then
			_condition = defaultMotionValues
		end
		return _condition
	end
	local getDefaultANDInitialValues = function()
		local _condition = motionDef.initial
		if _condition == nil then
			_condition = EMPTYOBJECT
		end
		local _object = table.clone(_condition)
		setmetatable(_object, nil)
		for _k, _v in defaultMotionValues do
			_object[_k] = _v
		end
		return _object
	end
	local instanceRef
	local updateReactiveStates = function(forcePropertyApplications)
		local _result = mb1downState
		if _result ~= nil then
			_result = _result.State
		end
		if _result == true then
			if currentReactiveState == "m1down" and forcePropertyApplications ~= true then
				return nil
			end
			currentReactiveState = "m1down"
			local _exp = instanceRef
			local _object = table.clone(getDefaultORInitialValues())
			setmetatable(_object, nil)
			for _k, _v in motionDef.whileClicked do
				_object[_k] = _v
			end
			for _k, _v in getInViewProperties() do
				_object[_k] = _v
			end
			ApplyMotionProperties(_exp, GetPropertiesFromMotionDef(_object), {
				Static = false,
				SpringControlled = springControlledMotions,
			}, motionConfig, UpdateMotionStateValue)
			return nil
		end
		local _result_1 = hoveringState
		if _result_1 ~= nil then
			_result_1 = _result_1.State
		end
		if _result_1 == true then
			if currentReactiveState == "hovering" and forcePropertyApplications ~= true then
				return nil
			end
			currentReactiveState = "hovering"
			local _exp = instanceRef
			local _object = table.clone(getDefaultORInitialValues())
			setmetatable(_object, nil)
			for _k, _v in motionDef.whileHovered do
				_object[_k] = _v
			end
			for _k, _v in getInViewProperties() do
				_object[_k] = _v
			end
			ApplyMotionProperties(_exp, GetPropertiesFromMotionDef(_object), {
				Static = false,
				SpringControlled = springControlledMotions,
			}, motionConfig, UpdateMotionStateValue)
			return nil
		end
		if currentReactiveState == nil and forcePropertyApplications ~= true then
			return nil
		end
		currentReactiveState = nil
		local _exp = instanceRef
		local _object = table.clone(getDefaultORInitialValues())
		setmetatable(_object, nil)
		for _k, _v in (motionDef.animate or motionDef.initial or {}) do
			_object[_k] = _v
		end
		for _k, _v in getInViewProperties() do
			_object[_k] = _v
		end
		ApplyMotionProperties(_exp, GetPropertiesFromMotionDef(_object), {
			Static = false,
			SpringControlled = springControlledMotions,
		}, motionConfig, UpdateMotionStateValue)
	end
	local onMotionDefUpdated = function(forcePropertyApplications)
		if motionDef.default ~= nil then
			defaultMotionValues = motionDef.default
		end
		if instanceRef == nil then
			return nil
		end
		if motionDef.whileHovered ~= nil and hoveringState == nil then
			hoveringState = State.new(false)
			local _arg0 = instanceRef:IsA("GuiObject")
			local _arg1_1 = `instanceRef is not a GuiObject, cannot use "whileHovered"`
			assert(_arg0, _arg1_1)
			hoveringState._dev.insert(instanceRef.MouseEnter:Connect(function()
				UpdateMotionStateBulk("hovered", true)
				hoveringState:SetState(true)
				updateReactiveStates()
			end))
			hoveringState._dev.insert(instanceRef.MouseLeave:Connect(function()
				UpdateMotionStateBulk("hovered", false)
				hoveringState:SetState(false)
				updateReactiveStates()
			end))
		else
			if hoveringState then
				UpdateMotionStateBulk("hovered", false)
				hoveringState:Destroy()
				hoveringState = nil
			end
		end
		if motionDef.whileClicked ~= nil and mb1downState == nil then
			mb1downState = State.new(false)
			local _arg0 = instanceRef:IsA("GuiButton")
			local _arg1_1 = `instanceRef is not a GuiButton, cannot use "whileClicked"`
			assert(_arg0, _arg1_1)
			mb1downState._dev.insert(instanceRef.MouseButton1Down:Connect(function()
				UpdateMotionStateBulk("clicked", true)
				mb1downState:SetState(true)
				updateReactiveStates()
			end))
			mb1downState._dev.insert(instanceRef.MouseButton1Up:Connect(function()
				UpdateMotionStateBulk("clicked", false)
				mb1downState:SetState(false)
				updateReactiveStates()
			end))
			mb1downState._dev.insert(instanceRef.MouseLeave:Connect(function()
				UpdateMotionStateBulk("clicked", false)
				mb1downState:SetState(false)
				updateReactiveStates()
			end))
		else
			if mb1downState then
				UpdateMotionStateBulk("clicked", false)
				mb1downState:Destroy()
				mb1downState = nil
			end
		end
		if motionDef.whileInView ~= nil and inViewState == nil then
			inViewState = State.new(false)
			local _arg0 = instanceRef:IsA("GuiObject")
			local _arg1_1 = `instanceRef is not a GuiObject, cannot use "whileInView"`
			assert(_arg0, _arg1_1)
			inViewState:ObserveNext(function()
				local _result = inViewState
				if _result ~= nil then
					_result = _result.State
				end
				UpdateMotionStateBulk("inView", _result)
				updateReactiveStates(true)
			end, { "State" })
			AddInViewState(instanceRef, inViewState)
		else
			RemoveInViewState(instanceRef)
			if inViewState then
				UpdateMotionStateBulk("inView", false)
				inViewState:Destroy()
				inViewState = nil
			end
		end
		updateReactiveStates(forcePropertyApplications)
	end
	local _motion = motion
	if type(_motion) == "function" then
		createEffect(function()
			motionDef = motion()
			onMotionDefUpdated(true)
		end)
	else
		motionDef = motion
		onMotionDefUpdated()
	end
	-- setting default state value before any ref is provided (defaults will exist in state.)
	local newMotionState = {}
	for key, value in pairs(defaultMotionValues) do
		if (string.match(key, "^%a")) == nil then
			-- is a special key, e.g. child selector like ".childName"
			continue
		end
		local propertyValueInfo = GetMotionPropertyValueInfo(value, motionConfig)
		newMotionState[key] = propertyValueInfo.value
	end
	motionStateObject:SetState(newMotionState)
	onWillMount(function(ref)
		-- assign instance ref before mounting
		instanceRef = ref
		onMotionDefUpdated()
		-- Might need to change to DescendantAdded/DescendantRemoved for nested changes. (also may only want to listen to child added if we detect any child keys, e.g. ".childName" within the motion property)
		instanceRef.ChildAdded:Connect(function()
			updateReactiveStates(true)
		end)
		instanceRef.ChildRemoved:Connect(function(child)
			updateReactiveStates(true)
			-- Remove instance from any spring controlled list.
			for _, springControlledMotion in pairs(springControlledMotions) do
				local targetSpringRecord = springControlledMotion
				local _targetIndex = targetSpringRecord._controlledInstances
				if _targetIndex ~= nil then
					local _child = child
					_targetIndex = (table.find(_targetIndex, _child) or 0) - 1
				end
				local targetIndex = _targetIndex
				if targetIndex ~= nil then
					local _result = targetSpringRecord._controlledInstances
					if _result ~= nil then
						table.remove(_result, targetIndex + 1)
					end
				end
			end
		end)
		if motionDef.initial ~= nil then
			-- Apply initially properties
			ApplyMotionProperties(instanceRef, GetPropertiesFromMotionDef(getDefaultANDInitialValues()), {
				Static = true,
				SpringControlled = springControlledMotions,
			}, motionConfig, UpdateMotionStateValue)
		else
			if motionDef.default then
				-- If no initial props are provided, then we need to apply default properties where initial normally gets ran (if initial is provided, default values will be added during initial cycle above).
				ApplyMotionProperties(instanceRef, GetPropertiesFromMotionDef(defaultMotionValues), {
					Static = true,
					SpringControlled = springControlledMotions,
				}, motionConfig, UpdateMotionStateValue)
			end
		end
	end)
	onMount(function()
		-- if (motionElementNode._has_motion === true) {
		-- 	print(`[MotionDef for error]:`, motionDef);
		-- 	error(
		-- 		`Motion() already applied to this component, only a single Motion() is allowed per component. "${instanceRef.GetFullName()}"`,
		-- 	);
		-- }
		-- motionElementNode._has_motion = true;
		if motionDef.animate ~= nil then
			local animateProps = motionDef.animate
			local _exp = instanceRef
			local _object = table.clone(getDefaultORInitialValues())
			setmetatable(_object, nil)
			for _k, _v in animateProps do
				_object[_k] = _v
			end
			ApplyMotionProperties(_exp, GetPropertiesFromMotionDef(_object), {
				Static = false,
				SpringControlled = springControlledMotions,
			}, motionConfig, UpdateMotionStateValue)
		end
	end)
	if motionDef.dismount ~= nil then
		local dismountProps = motionDef.dismount
		onWillDismount(function()
			return TS.Promise.new(function(resolve)
				local _exp = instanceRef
				local _object = table.clone(getDefaultORInitialValues())
				setmetatable(_object, nil)
				for _k, _v in dismountProps do
					_object[_k] = _v
				end
				ApplyMotionProperties(_exp, GetPropertiesFromMotionDef(_object), {
					Static = false,
					SpringControlled = springControlledMotions,
				}, motionConfig, UpdateMotionStateValue)
				task.wait(1)
				resolve()
			end)
		end)
	end
	return {
		props = motionState,
		states = motionStates,
	}
end
return {
	Motion = Motion,
}
