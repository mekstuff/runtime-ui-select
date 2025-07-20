-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    07/05/2025 18:36:33
	
]]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createCleanup = _vivid.createCleanup
local createEffect = _vivid.createEffect
local createState = _vivid.createState
local withProps = _vivid.withProps
local Theme = TS.import(script, script.Parent.Parent.Parent, "Utils").Theme
local RunService = game:GetService("RunService")
local function Spinner(props)
	local Properties = withProps(props, true)
	Properties.props = nil
	Properties.speed = nil
	Properties.enabled = nil
	local Rotation, setRotation = createState(0)
	createEffect(function()
		if props.enabled ~= true then
			return nil
		end
		local _condition = props.speed
		if _condition == nil then
			_condition = 5
		end
		local speed = _condition
		local Update = RunService.Heartbeat:Connect(function()
			setRotation(function(oldRot)
				return (oldRot + speed) % 360
			end)
		end)
		createCleanup(function()
			Update:Disconnect()
		end)
	end)
	local _result = props.props
	if _result ~= nil then
		_result = _result.Container
	end
	local _attributes = {
		Size = props.Size or UDim2.fromOffset(20, 20),
		AnchorPoint = props.AnchorPoint or Vector2.new(0.5, 0.5),
		Position = props.Position or UDim2.fromScale(0.5, 0.5),
		BackgroundTransparency = 1,
	}
	if _result then
		for _k, _v in _result do
			_attributes[_k] = _v
		end
	end
	local _attributes_1 = {
		Image = "rbxassetid://9875331611",
		ImageColor3 = Theme().MainText,
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Rotation = Rotation(),
	}
	for _k, _v in Properties do
		_attributes_1[_k] = _v
	end
	local _exp = Vivid.createElement("imagelabel", _attributes_1)
	local _result_1 = props.props
	if _result_1 ~= nil then
		_result_1 = _result_1.UIAspectRatioConstraint
	end
	local _attributes_2 = {}
	if _result_1 then
		for _k, _v in _result_1 do
			_attributes_2[_k] = _v
		end
	end
	return Vivid.createElement("frame", _attributes, _exp, Vivid.createElement("uiaspectratioconstraint", _attributes_2))
end
return {
	Spinner = Spinner,
}
