-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local _createState = TS.import(script, script.Parent.Parent, "create", "createState")
local createState = _createState.createState
local IsStatePropertyValue = _createState.IsStatePropertyValue
local createScope = TS.import(script, script.Parent.Parent, "create", "createScope").createScope
local createElement = TS.import(script, script.Parent.Parent, "create", "createElement").createElement
local GetElementNode = TS.import(script, script.Parent.Parent, "nodes", "Nodes").GetElementNode
-- TODO: Possible bug that affected focus view plugin plus sign display. If we used the "each" prop state within a child function of the forEach, if the child item is removed, e.g. we set
-- the "each" state to `[]`, the effect that is using the state within the forEach child function will run before forEach gets the time to Destroy the item. causing the effect function to run
-- even if technically the item will not exist.
local function forEach(props)
	local ForEachElementNode = GetElementNode()
	if ForEachElementNode == nil then
		error(`You may be using forEach() incorrectly. It should be used somewhere inside a createElement call.`)
	end
	local RenderListState, setRenderListState, RenderListStateObject = createState({})
	local ExistingRenderedItems = {}
	local PreviousNonUniqueRenderedItems = {}
	local UpdateState = function(EachList)
		for oldPrevNonUniqueKey, oldPrevNonUniqueValue in pairs(PreviousNonUniqueRenderedItems) do
			-- remove all previous items that didn't have a unique key
			oldPrevNonUniqueValue.object:Destroy()
			oldPrevNonUniqueValue.indexState:Destroy()
			PreviousNonUniqueRenderedItems[oldPrevNonUniqueKey] = nil
		end
		local NewExistingRenderedItems = {}
		local NewRenderList = {}
		if EachList == nil then
			return RenderListState
		end
		for key, value in pairs(EachList) do
			local ItemLoopScope = createScope(ForEachElementNode)
			ForEachElementNode.servant:Keep(ItemLoopScope)
			local uniqueId = if props.uniqueIdExtractor then props.uniqueIdExtractor(value, key) else nil
			if props.uniqueIdExtractor ~= nil then
				local _arg0 = uniqueId ~= nil
				local _arg1 = `could not extract unique id for forEach from uniqueIdExtractor for key: "{key}".`
				assert(_arg0, _arg1)
			end
			if uniqueId ~= nil then
				local TargetExisting = ExistingRenderedItems[uniqueId]
				if TargetExisting ~= nil then
					-- remove the state and object from the previous root servant
					-- so they don't get destroyed when cleaned up.
					-- ForEachRootNodeServant.Free(TargetExisting.state);
					-- ForEachRootNodeServant.Free(TargetExisting.object);
					local _object = TargetExisting.object
					table.insert(NewRenderList, _object)
					TargetExisting.setIndexState(key)
					local _result = TargetExisting.setPropsState
					if _result ~= nil then
						local _result_1
						if type(value) == "table" then
							local _object_1 = {}
							if value then
								for _k, _v in value do
									_object_1[_k] = _v
								end
							end
							_result_1 = _object_1
						else
							_result_1 = value
						end
						_result(_result_1)
					end
					NewExistingRenderedItems[uniqueId] = TargetExisting
					continue
				end
			end
			-- Create the element and states and update objects.
			-- For each item, create a seperate Servant to override the ElementNode, this way each element is seperated from the root
			-- "ItemLoopScope" handles seperating it
			createElement(function()
				local IndexState, setIndexState, IndexStateObject = createState(key)
				-- StateUpdateServant.Keep(IndexStateObject);
				local _children = props.children
				local _exp = type(_children) == "function"
				local _children_1 = props.children
				local _arg1 = `Invalid child passed to forEach(). ".children" should be a render function, got {typeof(_children_1)}`
				assert(_exp, _arg1)
				-- For cases where UniqueId is provided, props for that list will be a state, meaning any changes made will rerun effects that uses the .props
				local TargetValue = value
				local PropsState
				local setPropsState
				if uniqueId ~= nil then
					local ValueState, setValueState, ValueStateObject = createState(value)
					PropsState = ValueStateObject
					setPropsState = setValueState
					TargetValue = ValueState()
				end
				local _props = props
				local _exp_1 = TargetValue
				local _exp_2 = IndexState
				local _condition = uniqueId
				if _condition == nil then
					_condition = key
				end
				local RenderedItemInScope = _props.children(_exp_1, _exp_2, _condition)
				if uniqueId ~= nil then
					-- has a unique id but wasn't listed previously, store in new existing items array
					NewExistingRenderedItems[uniqueId] = {
						indexState = IndexStateObject,
						setIndexState = setIndexState,
						object = RenderedItemInScope,
						propsState = PropsState,
						setPropsState = setPropsState,
					}
				else
					-- doesn't have a unique id and will be re-render (destroyed and recreated) on next state change
					PreviousNonUniqueRenderedItems[key] = {
						indexState = IndexStateObject,
						setIndexState = setIndexState,
						object = RenderedItemInScope,
					}
				end
				table.insert(NewRenderList, RenderedItemInScope)
				return RenderedItemInScope
			end)
			ItemLoopScope.Close()
		end
		for oldUniqueKey, oldUniqueValue in pairs(ExistingRenderedItems) do
			if NewExistingRenderedItems[oldUniqueKey] then
				continue
			end
			oldUniqueValue.object:Destroy()
			oldUniqueValue.indexState:Destroy()
			local _result = oldUniqueValue.propsState
			if _result ~= nil then
				_result:Destroy()
			end
		end
		setRenderListState(NewRenderList)
		ExistingRenderedItems = NewExistingRenderedItems
	end
	local propsEach = props.each
	if IsStatePropertyValue(propsEach) == true then
		local eachState = propsEach._state
		local GetStateValue = function()
			if propsEach._targetpropertychain ~= nil then
				-- Added soley to support nested <For/> calls the uses props from parent that are reactive/(uniqueIdExtractor was defined).
				return (eachState.State)[propsEach._targetpropertychain[1]]
			else
				return eachState.State
			end
		end
		local Queued = false
		local UpdateStateQueue = function()
			if Queued == true then
				return nil
			end
			Queued = true
			task.defer(function()
				Queued = false
				UpdateState(GetStateValue())
			end)
		end
		RenderListStateObject._dev.insert(eachState:GetPropertyChangedSignal("State"):Connect(function()
			-- task.defer(() => {
			-- 	// Defer to attempt to fix bugs where the forEach will attempt to run before effect nodes closed. (Patch: 4/30/2025)
			-- 	// This patch helps with InfiniteScrollingFrame logic since (at the time) "fetchId" is a string (expected to be reactive) that tells the InfiniteScrollingFrame...
			-- 	// ... to reset, and then that reset calls the fetchItemsFunction and renders the content which then throws an error on the "ObserveNext" of the fetchId, "Attempt to createScope() inside createEffect()".
			-- 	UpdateState(GetStateValue() as object);
			-- });
			UpdateStateQueue()
		end))
		UpdateState(GetStateValue())
	else
		UpdateState(props.each)
	end
	RenderListStateObject.Destroying:Connect(function()
		UpdateState({})
		ForEachElementNode.servant:Destroy()
	end)
	return RenderListState
end
--[[
	
	export function forEach<T, I extends Instance, UID>(props: forEachProps<T, I, UID>): Vivid.StatefulCallback<I> {
		const ElementNode = GetElementNode();
	
		if (ElementNode === undefined) {
			throw `You may be using forEach() incorrectly. It should be used somewhere inside a createElement call.`;
		}
	
		const ElementNodeOriginalServant = ElementNode.servant;
	
		const [RenderListState, setRenderListState] = createState<I[]>([]);
		// ElementNode.servant.Keep(RenderListState);
	
		let ExistingRenderedItems: Record<
			string,
			{ object: Instance; state: State<unknown>; setstate: Vivid.StateSetter<unknown> }
		> = {};
		const PreviousNonUniqueRenderedItems: typeof ExistingRenderedItems = {};
	
		// const ForEachRootNodeServant = ElementNode.servant;
		// const ForEachRootNodeServant = new Servant();
		// ElementNode.servant.Keep(ForEachRootNodeServant);
		// const CustomForEachRootNode = CreateElementNode(ForEachRootNodeServant);
	
		let CurrentStateUpdateServant: Servant | undefined = undefined;
	
		const UpdateState = (EachList: object) => {
			// We internally keep adding the root element node to be the current active node
			// whenever the state is updating. This way, any created anytimes will refer to the correct
			// element node and "not the element node of the time the state updates".
			const StateUpdateServant = new Servant(); // We override the Servant each time so the created original root isn't linked to the created components
			// since the created components can be destroyed but the root should still exist. (we create a seperate servant and override the node for each item that is created below.)
			AddActiveNode("ElementNode", ElementNode);
	
			if (CurrentStateUpdateServant) {
				ElementNodeOriginalServant.Free(CurrentStateUpdateServant);
				CurrentStateUpdateServant.Destroy();
				CurrentStateUpdateServant = undefined;
			}
			CurrentStateUpdateServant = StateUpdateServant;
			ElementNodeOriginalServant.Keep(CurrentStateUpdateServant);
	
			for (const [oldPrevNonUniqueKey, oldPrevNonUniqueValue] of pairs(PreviousNonUniqueRenderedItems)) {
				// remove all previous items that didn't have a unique key
				oldPrevNonUniqueValue.object.Destroy();
				oldPrevNonUniqueValue.state.Destroy();
				delete PreviousNonUniqueRenderedItems[oldPrevNonUniqueKey];
			}
	
			const NewExistingRenderedItems: typeof ExistingRenderedItems = {}; // store all unique items for this loop here.
			const NewRenderList: I[] = [];
	
			// print("UPDATING STATE", ElementNode);
			for (const [key, value] of pairs(EachList)) {
				const uniqueId = props.uniqueIdExtractor
					? props.uniqueIdExtractor(value as never, key as never)
					: undefined;
				if (props.uniqueIdExtractor !== undefined) {
					assert(
						uniqueId !== undefined,
						`could not extract unique id for forEach from uniqueIdExtractor for key: "${key}".`,
					);
				}
	
				if (uniqueId !== undefined) {
					const TargetExisting = ExistingRenderedItems[uniqueId as keyof typeof ExistingRenderedItems];
					if (TargetExisting !== undefined) {
						// remove the state and object from the previous root servant
						// so they don't get destroyed when cleaned up.
						// ForEachRootNodeServant.Free(TargetExisting.state);
						// ForEachRootNodeServant.Free(TargetExisting.object);
	
						NewRenderList.push(TargetExisting.object as I);
						TargetExisting.setstate(key);
						NewExistingRenderedItems[uniqueId as keyof typeof ExistingRenderedItems] = TargetExisting; // pass to the unique items for this loop so it's considered and not destroyed.
						continue;
					}
				}
	
				// Create the element and states and update objects.
				// For each item, create a seperate Servant to override the ElementNode, this way each element is seperated from the root
				const ItemOverrideServant = new Servant();
				CurrentStateUpdateServant.Keep(ItemOverrideServant); // so it gets cleaned up with the root if needed.
				ElementNode.servant = ItemOverrideServant; // Override the ElementNode Servant so each item has it own servant and can be destroyed without destroying the entire "tree".
	
				createElement(() => {
					const [IndexState, setIndexState, IndexStateObject] = createState(key);
					StateUpdateServant.Keep(IndexStateObject);
					assert(
						typeIs(props.children, "function"),
						`Invalid child passed to forEach(). ".children" should be a render function, got ${typeOf(
							props.children,
						)}`,
					);
					const RenderedItemInScope = props.children(
						value as never,
						IndexState as never,
						uniqueId ?? (key as never),
					);
					if (uniqueId !== undefined) {
						// has a unique id but wasn't listed previously, store in new existing items array
						NewExistingRenderedItems[uniqueId as keyof typeof ExistingRenderedItems] = {
							state: IndexStateObject,
							setstate: setIndexState,
							object: RenderedItemInScope,
						};
					} else {
						// doesn't have a unique id and will be re-render (destroyed and recreated) on next state change
						PreviousNonUniqueRenderedItems[key as keyof typeof ExistingRenderedItems] = {
							state: IndexStateObject,
							setstate: setIndexState,
							object: RenderedItemInScope,
						};
					}
					NewRenderList.push(RenderedItemInScope as I);
					return RenderedItemInScope;
				});
	
				ElementNode.servant = CurrentStateUpdateServant;
			}
	
			for (const [oldUniqueKey, oldUniqueValue] of pairs(ExistingRenderedItems)) {
				if (NewExistingRenderedItems[oldUniqueKey]) {
					continue;
				}
				// ForEachRootNodeServant.Free(oldUniqueValue.state);
				// ForEachRootNodeServant.Free(oldUniqueValue.object);
				// remove all previous items that had unique keys but are no longer in the array have a unique key
				oldUniqueValue.object.Destroy();
				oldUniqueValue.state.Destroy();
			}
	
			RemoveActiveNode("ElementNode", ElementNode); // Remove our CustomForEachRootNode from the Node Stack.
			ElementNode.servant = ElementNodeOriginalServant; // set back to  be the original servant.
	
			setRenderListState(NewRenderList);
			ExistingRenderedItems = NewExistingRenderedItems;
		};
	
		if (IsStatePropertyValue(props.each)) {
			const eachState = props.each._state;
			ElementNode.servant.Keep(
				eachState.Observe(() => {
					UpdateState(eachState.State as object);
				}, ["State"]),
			);
		} else {
			UpdateState(props.each as object);
		}
	
		return RenderListState as unknown as Vivid.StatefulCallback<I>;
	}
	
]]
--[[
	
	export function forEach<
		ElementType = Instance,
		Arr extends object = object,
		// eslint-disable-next-line
		K = Arr extends any[] ? number : keyof Arr,
		// eslint-disable-next-line
		V = Arr extends any[] ? Arr[number] : Arr[keyof Arr],
		RT = unknown,
	>(
		List: Arr,
		/**
		 * Based on the key,value pair, return a unique id for that item.
		 *
		keyExtractor: (key: K, value: V) => RT,
		/**
		 * Unique key is what was returned from the KeyExtractor, the key refers to the current
		 * key for that unique item with the object ( If it is an array and items were removed, the key )
		 * will change, hence why key is a state and uniqueKey isn't. The "props" is the content of the array.
		 *
		createElementFunc: Vivid.FC.Render<
			V extends object
				? V
				: { value: V } & {
						key: Vivid.StatefulCallback<K>;
						uid: RT;
				  },
			Instance,
			true
		>,
	): Vivid.StatefulCallback<ElementType[]> {
		const ElementNode = GetElementNode();
		if (ElementNode === undefined) {
			throw `You may be using forEach() incorrectly. It should be used somewhere inside a createElement call.`;
		}
		const [RenderListState, setRenderListState] = createState<Instance[]>([]);
		ElementNode.servant.Keep(RenderListState);
	
		let PreviousExistingComponents: Record<string, { _keyState: State<unknown>; _component: Instance }> = {};
	
		const UpdateState = (StateValue: typeof List) => {
			const _newRenderList: Instance[] = [];
			const _extractedKeysToRemain: typeof PreviousExistingComponents = {};
	
			for (const [key, value] of pairs(StateValue)) {
				const ExtractedKey = keyExtractor(key as never, value as never);
				const ExtractedKeyExists = PreviousExistingComponents[ExtractedKey as never];
				if (ExtractedKeyExists !== undefined) {
					// the key exists, update the "key/index" state of the component
					ExtractedKeyExists._keyState.setState(key);
					_extractedKeysToRemain[ExtractedKey as string] = ExtractedKeyExists;
					continue;
				}
	
				let ___KeyInListStateObject: State<unknown>;
				const CreatedElement = createElement(() => {
					const [_KeyInListState, _setKeyInListState, _KeyInListStateObject] = createState(key);
					___KeyInListStateObject = _KeyInListStateObject;
					ElementNode?.servant.Keep(_KeyInListState);
					return createElement(createElementFunc, {
						...value,
						key: _KeyInListState,
						uid: ExtractedKey,
					} as never);
				});
				_newRenderList.push(CreatedElement as never);
				_extractedKeysToRemain[ExtractedKey as string] = {
					_component: CreatedElement as never,
					_keyState: ___KeyInListStateObject!,
				};
			}
			for (const [Key, Value] of pairs(PreviousExistingComponents)) {
				if (_extractedKeysToRemain[Key] === undefined) {
					Value._component.Destroy();
					Value._keyState.Destroy();
				}
			}
			setRenderListState(_newRenderList);
			PreviousExistingComponents = _extractedKeysToRemain;
		};
	
		if (IsStatePropertyValue(List)) {
			const Observer = List._state.Observe(() => {
				UpdateState(List._state.State as typeof List);
			}, ["State"]);
	
			ElementNode?.servant.Keep(Observer);
		} else {
			UpdateState(List);
		}
	
		return RenderListState as never;
	}
	
	
]]
return {
	forEach = forEach,
}
