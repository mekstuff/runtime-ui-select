-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 18:44:10
	
		TODO: - Since we're using forEach, if a SendToast from SendToastProvider is to be called and "children" pro defined,
		if the SendToast id were to already exists, the duplicated children render will be called, causing multiple children renders
		for everytime it is called. This is intended but when the Toast is removed, only 1 of the children called components will be cleaned up.
	
		e.g. Code:
		```ts
			ToastsUIController.SendToast({
			id: "invite-friend-reward-perks-info",
			icon: Icons().AddUser,
			Text: "You will be eligible to receive (1) free queue token for every player that joins from your invite link!",
			lifetime: false,
			dismissable: true,
			children: createElement(() => {
				print("rendered");
				// onDismount(() => {
				// 	print("root dismounted");
				// });
				return (
					<frame AutomaticSize={Enum.AutomaticSize.XY} BackgroundTransparency={1}>
						<Switch conditional={createEffect(() => Settings().IsInivitingFriends)()}>
							<Case condition={true}>
								{() => {
									onMount(() => {
										print("spinner mounted");
									});
									onDismount(() => {
										print("spinner dismounted");
									});
									return (
										<Spinner
											Position={UDim2.fromOffset(math.random(0, 10), 0)}
											Size={UDim2.fromOffset(10, 10)}
											enabled
											ImageColor3={BrickColor.random().Color}
										/>
									);
								}}
							</Case>
						</Switch>
					</frame>
				);
			}),
		```
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createSpring = _vivid.createSpring
local createState = _vivid.createState
local For = _vivid.For
local onMount = _vivid.onMount
local use = _vivid.use
local withProps = _vivid.withProps
local Toast = TS.import(script, script.Parent, "Toast").Toast
local HttpService = game:GetService("HttpService")
--[[
	*
	 * If `true`, all toasts will be dismissed.
	 * If `Toast`, the ID of the toast will be dismissed.
	 * If `string`, the ID of the toast will be dismissed.
	 
]]
local function CreateSendToastProvider()
	local SendToastProvider
	SendToastProvider = {
		callback = function(Toast)
			local _provider = SendToastProvider.provider
			local _arg0 = type(_provider) == "function"
			assert(_arg0, "Attempting to use SendToastProvider.provider before Provider is provided! Are you calling the function before you create the component?")
			SendToastProvider.provider(Toast)
		end,
		provider = nil,
	}
	return SendToastProvider
end
local function CreateDismissToastProvider()
	local DismissToastProvider
	DismissToastProvider = {
		callback = function(Toast)
			local _provider = DismissToastProvider.provider
			local _arg0 = type(_provider) == "function"
			assert(_arg0, "Attempting to use DismissToastProvider.provider before Provider is provided! Are you calling the function before you create the component?")
			DismissToastProvider.provider(Toast)
		end,
		provider = nil,
	}
	return DismissToastProvider
end
--[[
	*
	 * This allows you to create functions for Sending and Dismissing toasts.
	 *
	 * @example
	 * ```tsx
	 * const SendToastProvider = CreateSendToastProvider();
	 * const DismissToastProvider = CreateDismissToastProvider();
	 *
	 * <>
	 * 	<ToastsListProvider sendToastProvider={SendToastProvider} dismissToastProvider={DismissToastProvider} />
	 * </>
	 *
	 * export const SendToast = SendToastProvider.callback; // You can call this callback anywhere to send a toast.
	 * export const DismissToast = DismissToastProvider.callback; // You can call this callback anywhere to dismiss a toast.
	 * ```
	 *
	 * NOTE: If `buttonHidden` is `undefined` and dismissable is not set to `true` and not `buttonClicked` callback is provided, `buttonHidden` will become `true`
	 * NOTE: `lifetime` for Toasts default to `20` if value is `undefined`. setting value to `false` will disable auto dismissal after lifetime period.
	 
]]
local ToastsList
local function ToastsListProvider(props)
	local Properties = withProps(props, true)
	Properties.sendToastProvider = nil
	Properties.dismissToastProvider = nil
	local Toasts, setToasts = createState({})
	local sendToastProvider = props.sendToastProvider
	local dismissToastProvider
	if sendToastProvider ~= nil then
		local _arg0 = type(setToasts) == "function"
		local _arg1 = `setToasts needs to be provided to use sendToastProvider.`
		assert(_arg0, _arg1)
		local _arg0_1 = sendToastProvider.provider == nil
		local _arg1_1 = `A "provider" already exists on sendToastProvider ({props.sendToastProvider}). Are you passing the sendToastProvider to multiple ToastLists?`
		assert(_arg0_1, _arg1_1)
		sendToastProvider.provider = function(Toast)
			local _exp = use(function()
				return Toasts()
			end)
			-- ▼ ReadonlyArray.findIndex ▼
			local _callback = function(f)
				return f.id == Toast.id
			end
			local _result = -1
			for _i, _v in _exp do
				if _callback(_v, _i - 1, _exp) == true then
					_result = _i - 1
					break
				end
			end
			-- ▲ ReadonlyArray.findIndex ▲
			local ExistingIndex = _result
			-- ID already exists.
			if ExistingIndex > -1 then
				dismissToastProvider.callback(Toast)
				task.wait()
				-- return;
			end
			local _condition = Toast.id
			if _condition == nil then
				_condition = HttpService:GenerateGUID()
			end
			Toast.id = _condition
			Toast.dismissToastListProvider = dismissToastProvider
			if Toast.dismissable ~= true and Toast.buttonHidden == nil and Toast.buttonClicked == nil then
				Toast.buttonHidden = true
			end
			local _arg0_2 = type(setToasts) == "function"
			local _arg1_2 = `setToasts needs to be provided to use sendToastProvider.`
			assert(_arg0_2, _arg1_2)
			setToasts(function(old)
				local _old = old
				local _toast = Toast
				table.insert(_old, _toast)
				local _array = {}
				local _length = #_array
				table.move(old, 1, #old, _length + 1, _array)
				local r = _array
				return r
			end)
			-- lifetime
			if Toast.lifetime == false then
				return nil
			end
			local _lifetime = Toast.lifetime
			task.delay(if type(_lifetime) == "number" then Toast.lifetime else 20, function()
				dismissToastProvider.provider(Toast)
			end)
		end
	end
	dismissToastProvider = props.dismissToastProvider
	if dismissToastProvider ~= nil then
		-- assert(typeIs(setToasts, "function"), `setToasts needs to be provided to use dismissToastProvider.`);
		local _arg0 = dismissToastProvider.provider == nil
		local _arg1 = `A "provider" already exists on dismissToastProvider ({props.dismissToastProvider}). Are you passing the dismissToastProvider to multiple ToastLists?`
		assert(_arg0, _arg1)
		dismissToastProvider.provider = function(Toast)
			local _arg0_1 = type(setToasts) == "function"
			local _arg1_1 = `setToasts needs to be provided to use dismissToastProvider.`
			assert(_arg0_1, _arg1_1)
			setToasts(function(old)
				local ToastId
				local _toast = Toast
				if type(_toast) == "boolean" then
					-- Dismiss all toasts.
					return {}
				end
				local _toast_1 = Toast
				if type(_toast_1) == "string" then
					ToastId = Toast
					-- IndexOf = old.findIndex((f) => f.id === Toast);
				else
					ToastId = use(function()
						return Toast.id
					end)
					local _id = Toast.id
					local _arg0_2 = type(_id) == "string"
					assert(_arg0_2, "ToastId not a string, cannot dismissToastProvider.provider()")
					-- IndexOf = old.findIndex((f) => f.id === Toast.id);
				end
				-- ▼ ReadonlyArray.findIndex ▼
				local _callback = function(f)
					return f.id == ToastId
				end
				local _result = -1
				for _i, _v in old do
					if _callback(_v, _i - 1, old) == true then
						_result = _i - 1
						break
					end
				end
				-- ▲ ReadonlyArray.findIndex ▲
				local IndexOf = _result
				if IndexOf <= -1 then
					-- Nothing removed, no need to "render over"/"make check" ForEach.
					return old
				end
				table.remove(old, IndexOf + 1)
				local _array = {}
				local _length = #_array
				table.move(old, 1, #old, _length + 1, _array)
				return _array
			end)
		end
	end
	local _attributes = {
		toasts = Toasts(),
	}
	for _k, _v in Properties do
		_attributes[_k] = _v
	end
	return Vivid.createElement(ToastsList, _attributes)
end
function ToastsList(props)
	local Properties = withProps(props, true)
	Properties.props = nil
	Properties.toasts = nil
	local _attributes = {
		Size = UDim2.fromScale(1, 1),
	}
	for _k, _v in Properties do
		_attributes[_k] = _v
	end
	local _result = props.props
	if _result ~= nil then
		_result = _result.UIPadding
	end
	local _attributes_1 = {
		PaddingLeft = UDim.new(0, 3),
		PaddingRight = UDim.new(0, 3),
		PaddingBottom = UDim.new(0, 4),
	}
	if _result then
		for _k, _v in _result do
			_attributes_1[_k] = _v
		end
	end
	local _exp = Vivid.createElement("uipadding", _attributes_1)
	local _result_1 = props.props
	if _result_1 ~= nil then
		_result_1 = _result_1.UIListLayout
	end
	local _attributes_2 = {
		FillDirection = Enum.FillDirection.Vertical,
		VerticalAlignment = Enum.VerticalAlignment.Bottom,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		Padding = UDim.new(0, 6),
	}
	if _result_1 then
		for _k, _v in _result_1 do
			_attributes_2[_k] = _v
		end
	end
	return Vivid.createElement("frame", _attributes, _exp, Vivid.createElement("uilistlayout", _attributes_2), Vivid.createElement(For, {
		each = props.toasts,
		uniqueIdExtractor = function(v)
			return v.id
		end,
		children = function(toastProps)
			local ContainerPosition, setContainerPosition = createSpring(UDim2.fromScale(2), 0.75, 1.5)
			onMount(function()
				setContainerPosition(UDim2.fromScale(0, 0))
			end)
			local _attributes_3 = table.clone(withProps(toastProps, true))
			setmetatable(_attributes_3, nil)
			return Vivid.createElement("frame", {
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.Y,
				Size = UDim2.fromScale(1),
			}, Vivid.createElement("frame", {
				Position = ContainerPosition(),
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.Y,
				Size = UDim2.fromScale(1),
			}, Vivid.createElement(Toast, _attributes_3)))
		end,
	}))
end
return {
	CreateSendToastProvider = CreateSendToastProvider,
	CreateDismissToastProvider = CreateDismissToastProvider,
	ToastsListProvider = ToastsListProvider,
	ToastsList = ToastsList,
}
