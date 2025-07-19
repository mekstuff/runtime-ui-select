-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 18:34:50
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local Case = _vivid.Case
local createCleanup = _vivid.createCleanup
local createEffect = _vivid.createEffect
local createRef = _vivid.createRef
local createState = _vivid.createState
local Switch = _vivid.Switch
local use = _vivid.use
local withProps = _vivid.withProps
local _Utils = TS.import(script, script.Parent.Parent.Parent, "Utils")
local Theme = _Utils.Theme
local Units = _Utils.Units
local Input = TS.import(script, script.Parent, "Input").Input
local function CreateLabelEditTextCallback()
	local Provider
	Provider = {
		callbackAsync = function(...)
			local args = { ... }
			-- Callback();
			local _onCallback = Provider.onCallback
			assert(_onCallback, "Callback not assigned to LabelEditTextProvider")
			return Provider.onCallback(unpack(args))
		end,
	}
	return Provider
end
local function Label(props)
	local InputRef = createRef()
	local ButtonRef = createRef()
	local IsEditingText, setIsEditingText, IsEditingTextState = createState(false)
	local Properties = withProps(props, true)
	local _object = {
		Position = Properties.Position,
		AnchorPoint = Properties.AnchorPoint,
		Font = Properties.Font,
		Text = Properties.Text,
		TextSize = Properties.TextSize,
		TextColor3 = Properties.TextColor3,
		TextFits = Properties.TextFits,
		TextScaled = Properties.TextScaled,
		TextWrapped = Properties.TextWrapped,
		TextStrokeColor3 = Properties.TextStrokeColor3,
		TextStrokeTransparency = Properties.TextStrokeTransparency,
		TextXAlignment = Properties.TextXAlignment,
		TextYAlignment = Properties.TextYAlignment,
		TextTransparency = Properties.TextTransparency,
		BackgroundColor3 = Properties.BackgroundColor3,
		BackgroundTransparency = Properties.BackgroundTransparency,
		LayoutOrder = Properties.LayoutOrder,
	}
	local _spread = Properties.editTextInputProps
	if _spread then
		for _k, _v in _spread do
			_object[_k] = _v
		end
	end
	local InputProperties = _object
	Properties.editText = nil
	Properties.editTextInputProps = nil
	local WasLastInputCancelled = false
	if props.editText ~= nil then
		props.editText.onCallback = function()
			setIsEditingText(true)
			task.wait()
			local InputObject = use(function()
				return InputRef()
			end)
			if InputObject == nil then
				return nil
			end
			task.defer(function()
				InputObject:CaptureFocus()
				task.wait()
				InputObject.SelectionStart = 1
				InputObject.CursorPosition = #InputObject.Text + 1
			end)
			IsEditingTextState:GetPropertyChangedSignal("State"):Wait()
			if WasLastInputCancelled == true then
				WasLastInputCancelled = false
				return nil
			end
			return InputObject.Text
		end
		createEffect(function()
			local TextBox = InputRef()
			if TextBox == nil then
				return nil
			end
			local TriggerCompleted = function(Cancelled)
				local _condition = Cancelled
				if _condition == nil then
					_condition = false
				end
				WasLastInputCancelled = _condition
				setIsEditingText(false)
			end
			local FocusLostListener = TextBox.FocusLost:Connect(function(_, input)
				if input.KeyCode == Enum.KeyCode.Escape then
					TriggerCompleted(true)
				end
				TriggerCompleted()
			end)
			createCleanup(function()
				FocusLostListener:Disconnect()
			end)
		end)
	end
	local _attributes = {
		forwardRef = props.ref,
		AutoButtonColor = false,
		Active = false,
		Interactable = false,
		TextTruncate = Enum.TextTruncate.SplitWord,
		AutomaticSize = Enum.AutomaticSize.XY,
		TextSize = Units().BaseTextSize,
		TextColor3 = Theme().MainText,
		BackgroundTransparency = 1,
	}
	for _k, _v in Properties do
		_attributes[_k] = _v
	end
	_attributes.ref = ButtonRef
	_attributes.Visible = createEffect(function()
		if IsEditingText() == true then
			return false
		end
		local _condition = (props.Visible)
		if _condition == nil then
			_condition = true
		end
		return _condition
	end)()
	return Vivid.createElement(Vivid.createFragment, nil, Vivid.createElement("textbutton", _attributes), Vivid.createElement(Switch, {
		conditional = IsEditingText(),
	}, Vivid.createElement(Case, {
		condition = true,
	}, function()
		local _attributes_1 = table.clone(InputProperties)
		setmetatable(_attributes_1, nil)
		_attributes_1.ref = InputRef
		return Vivid.createElement(Input, _attributes_1)
	end), Vivid.createElement(Case, {
		condition = false,
	}, function()
		return Vivid.createElement(Vivid.createFragment)
	end)))
end
return {
	CreateLabelEditTextCallback = CreateLabelEditTextCallback,
	Label = Label,
}
