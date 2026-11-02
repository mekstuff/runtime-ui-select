-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    01/06/2025 14:18:54
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local Case = _vivid.Case
local createEffect = _vivid.createEffect
local createRef = _vivid.createRef
local createState = _vivid.createState
local onMount = _vivid.onMount
local Switch = _vivid.Switch
local withProps = _vivid.withProps
local ContentProvider = game:GetService("ContentProvider")
local ImageLoadTimeout = 5
local function Image(props)
	local Properties = withProps(props, true)
	Properties.props = nil
	Properties.children = nil
	Properties.loading = nil
	Properties.fallback = nil
	Properties.Name = nil
	Properties.Size = nil
	Properties.Active = nil
	Properties.Position = nil
	Properties.Archivable = nil
	Properties.AnchorPoint = nil
	local ImageLoaded, setImageLoaded, ImageLoadedStateObj = createState(false)
	local ImageFailed, setImageFailed = createState(false)
	local ImageRef = createRef()
	local CurrentUpateImageStatusThread = nil
	local UpdateImageStatus = function()
		if CurrentUpateImageStatusThread ~= nil then
			task.cancel(CurrentUpateImageStatusThread)
			CurrentUpateImageStatusThread = nil
		end
		local Image = ImageRef()
		if Image.Image == "" or Image.IsLoaded == true then
			setImageFailed(false)
			setImageLoaded(true)
			return nil
		end
		CurrentUpateImageStatusThread = task.spawn(function()
			setImageFailed(false)
			setImageLoaded(false)
			ContentProvider:PreloadAsync({ Image.Image }, function(_, status)
				task.wait(0.5)
				if status == Enum.AssetFetchStatus.Success then
					setImageLoaded(true)
					return nil
				end
				setImageLoaded(false)
				setImageFailed(true)
			end)
		end)
	end
	onMount(function()
		UpdateImageStatus()
	end)
	local _result = props.props
	if _result ~= nil then
		_result = _result.Container
	end
	local _attributes = {
		Name = props.Name,
		Size = props.Size,
		Active = props.Active,
		Position = props.Position,
		BackgroundTransparency = 1,
		Archivable = props.Archivable,
		AnchorPoint = props.AnchorPoint,
	}
	if _result then
		for _k, _v in _result do
			_attributes[_k] = _v
		end
	end
	local _result_1 = props.props
	if _result_1 ~= nil then
		_result_1 = _result_1.Container
		if _result_1 ~= nil then
			_result_1 = _result_1.children
		end
	end
	local _attributes_1 = {
		ref = ImageRef,
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
	}
	for _k, _v in Properties do
		_attributes_1[_k] = _v
	end
	_attributes_1.Image = function()
		task.defer(function()
			return UpdateImageStatus()
		end)
		return props.Image
	end
	_attributes_1.Visible = function()
		if ImageLoaded() == false or ImageFailed() == true then
			return false
		end
		local _condition = (props.Visible)
		if _condition == nil then
			_condition = true
		end
		return _condition
	end
	return Vivid.createElement("frame", _attributes, _result_1, Vivid.createElement("imagelabel", _attributes_1, props.children), Vivid.createElement(Switch, {
		conditional = createEffect(function()
			return ImageLoaded() == false and ImageFailed() == false
		end)(),
	}, Vivid.createElement(Case, {
		condition = true,
	}, function()
		if props.loading ~= nil then
			return props.loading
		end
		return Vivid.createElement(Vivid.Fragment)
	end), Vivid.createElement(Case, {
		condition = false,
	}, function()
		return Vivid.createElement(Vivid.Fragment)
	end)), Vivid.createElement(Switch, {
		conditional = createEffect(function()
			return ImageLoaded() == false and ImageFailed() == true
		end)(),
	}, Vivid.createElement(Case, {
		condition = true,
	}, function()
		if props.fallback ~= nil then
			return props.fallback
		end
		return Vivid.createElement(Vivid.Fragment)
	end), Vivid.createElement(Case, {
		condition = false,
	}, function()
		return Vivid.createElement(Vivid.Fragment)
	end)))
end
return {
	Image = Image,
}
