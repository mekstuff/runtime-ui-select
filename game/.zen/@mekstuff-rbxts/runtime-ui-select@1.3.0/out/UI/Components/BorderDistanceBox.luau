-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    18/07/2025 17:47:27
	
]]
local GuiService = game:GetService("GuiService")
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local Case = _vivid.Case
local createCleanup = _vivid.createCleanup
local createEffect = _vivid.createEffect
local createState = _vivid.createState
local Switch = _vivid.Switch
local use = _vivid.use
local withProps = _vivid.withProps
local Servant = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "core").out).Servant
local Tags = TS.import(script, script.Parent.Parent.Parent, "Core", "Constants", "Tags").Tags
local BorderDistanceLine = TS.import(script, script.Parent.Parent, "Screens", "BorderDistanceLine").BorderDistanceLine
local Theme = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid-ui").out).Theme
local SettingsContext = TS.import(script, script.Parent.Parent.Parent, "Contexts", "SettingsContexts").SettingsContext
local function RenderBorderDistanceLine(props)
	local Properties = withProps(props, true)
	Properties.truthy = nil
	return Vivid.createElement(Switch, {
		conditional = createEffect(function()
			return props.truthy == true
		end)(),
	}, Vivid.createElement(Case, {
		condition = true,
	}, function()
		local _attributes = table.clone(Properties)
		setmetatable(_attributes, nil)
		return Vivid.createElement(BorderDistanceLine, _attributes)
	end), Vivid.createElement(Case, {
		condition = false,
	}, function()
		return Vivid.createElement(Vivid.createFragment)
	end))
end
local function BorderDistanceBox(props)
	local AdorneeStatic = use(function()
		return props.Adornee
	end)
	local AdorneeAbsoluteSize, setAdorneeAbsoluteSize = createState(use(function()
		return AdorneeStatic.AbsoluteSize
	end))
	local AdorneeAbsolutePosition, setAdorneeAbsolutePosition = createState(use(function()
		return AdorneeStatic.AbsolutePosition
	end))
	local Root, setRoot = createState(nil)
	local RootAbsoluteSize, setRootAbsoluteSize = createState(Vector2.zero)
	local RootAbsolutePosition, setRootAbsolutePosition = createState(Vector2.zero)
	local AncestorScreenGui, setAncestorScreenGui = createState(nil)
	local LeftDistanceDiff, setLeftDistanceDiff = createState(0)
	local TopDistanceDiff, setTopDistanceDiff = createState(0)
	local RightDistanceDiff, setRightDistanceDiff = createState(0)
	local BottomDistanceDiff, setBottomDistanceDiff = createState(0)
	createEffect(function()
		local AncestryChangedListener = props.Adornee.AncestryChanged:Connect(function()
			setAncestorScreenGui(props.Adornee:FindFirstAncestorWhichIsA("ScreenGui"))
		end)
		setAncestorScreenGui(props.Adornee:FindFirstAncestorWhichIsA("ScreenGui"))
		createCleanup(function()
			AncestryChangedListener:Disconnect()
		end)
	end)
	createEffect(function()
		local CurrentRoot = Root()
		local CurrentAncestorScreenGui = AncestorScreenGui()
		setLeftDistanceDiff(AdorneeAbsolutePosition().X - RootAbsolutePosition().X)
		setTopDistanceDiff(AdorneeAbsolutePosition().Y - RootAbsolutePosition().Y + (if CurrentRoot and CurrentAncestorScreenGui and CurrentRoot:IsA("Camera") then if CurrentAncestorScreenGui.IgnoreGuiInset == true then GuiService.TopbarInset.Height else 0 else 0))
		setRightDistanceDiff(RootAbsolutePosition().X + RootAbsoluteSize().X - (AdorneeAbsolutePosition().X + AdorneeAbsoluteSize().X))
		setBottomDistanceDiff(RootAbsolutePosition().Y + RootAbsoluteSize().Y - (AdorneeAbsolutePosition().Y + AdorneeAbsoluteSize().Y) - (if CurrentRoot and CurrentAncestorScreenGui and CurrentRoot:IsA("Camera") then if CurrentAncestorScreenGui.IgnoreGuiInset == true then GuiService.TopbarInset.Height else 0 else 0))
	end)
	createEffect(function()
		local TargetRoot = Root()
		if TargetRoot == nil then
			setRootAbsoluteSize(Vector2.zero)
			setRootAbsolutePosition(Vector2.zero)
			return nil
		end
		local RootServant = Servant.new()
		if TargetRoot:IsA("Camera") then
			RootServant:Keep(TargetRoot:GetPropertyChangedSignal("ViewportSize"):Connect(function()
				setRootAbsoluteSize(TargetRoot.ViewportSize)
			end))
			setRootAbsoluteSize(TargetRoot.ViewportSize)
			setRootAbsolutePosition(Vector2.zero)
		end
		if TargetRoot:IsA("GuiObject") then
			RootServant:Keep(TargetRoot:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				setRootAbsoluteSize(TargetRoot.AbsoluteSize)
			end), TargetRoot:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				setRootAbsolutePosition(TargetRoot.AbsolutePosition)
			end))
			setRootAbsoluteSize(TargetRoot.AbsoluteSize)
			setRootAbsolutePosition(TargetRoot.AbsolutePosition)
		end
		createCleanup(function()
			RootServant:Destroy()
		end)
	end)
	createEffect(function()
		local UpdateRoot = function()
			if SettingsContext.CalculateBorderBoxRelativeToViewport.get() == true then
				setRoot(game.Workspace.CurrentCamera)
				return nil
			end
			local RootGuiObject = props.Adornee:FindFirstAncestorWhichIsA("GuiObject")
			if RootGuiObject == nil then
				setRoot(game.Workspace.CurrentCamera)
				return nil
			end
			setRoot(RootGuiObject)
		end
		local AdorneeParentListener = props.Adornee:GetPropertyChangedSignal("Parent"):Connect(UpdateRoot)
		UpdateRoot()
		createCleanup(function()
			AdorneeParentListener:Disconnect()
		end)
	end)
	createEffect(function()
		local AbsolutePositionChangedListener = props.Adornee:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
			if props.Adornee == nil then
				return nil
			end
			setAdorneeAbsolutePosition(props.Adornee.AbsolutePosition)
		end)
		createCleanup(function()
			AbsolutePositionChangedListener:Disconnect()
		end)
	end)
	createEffect(function()
		local AbsoluteSizeChangedListener = props.Adornee:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			if props.Adornee == nil then
				return nil
			end
			setAdorneeAbsoluteSize(props.Adornee.AbsoluteSize)
		end)
		createCleanup(function()
			AbsoluteSizeChangedListener:Disconnect()
		end)
	end)
	return Vivid.createElement("frame", {
		tags = { Tags.IgnoreHoverDetection },
		BackgroundTransparency = 0.8,
		BackgroundColor3 = props.BackgroundColor3,
		Size = createEffect(function()
			return UDim2.fromOffset(AdorneeAbsoluteSize().X, AdorneeAbsoluteSize().Y)
		end),
		Position = createEffect(function()
			return UDim2.fromOffset(AdorneeAbsolutePosition().X, AdorneeAbsolutePosition().Y)
		end),
	}, Vivid.createElement(RenderBorderDistanceLine, {
		truthy = SettingsContext.ShowLeftBorderBox.get(),
		Thickness = 2,
		BorderColor = Theme().ButtonBorder,
		PrimaryColor = props.BackgroundColor3,
		TextColor = props.TextColor3,
		Length = LeftDistanceDiff(),
		Position = "Left",
	}), Vivid.createElement(RenderBorderDistanceLine, {
		truthy = SettingsContext.ShowTopBorderBox.get(),
		Thickness = 2,
		BorderColor = Theme().ButtonBorder,
		PrimaryColor = props.BackgroundColor3,
		TextColor = props.TextColor3,
		Length = TopDistanceDiff(),
		Position = "Top",
	}), Vivid.createElement(RenderBorderDistanceLine, {
		truthy = SettingsContext.ShowRightBorderBox.get(),
		Thickness = 2,
		BorderColor = Theme().ButtonBorder,
		PrimaryColor = props.BackgroundColor3,
		TextColor = props.TextColor3,
		Length = RightDistanceDiff(),
		Position = "Right",
	}), Vivid.createElement(RenderBorderDistanceLine, {
		truthy = SettingsContext.ShowBottomBorderBox.get(),
		Thickness = 2,
		BorderColor = Theme().ButtonBorder,
		PrimaryColor = props.BackgroundColor3,
		TextColor = props.TextColor3,
		Length = BottomDistanceDiff(),
		Position = "Bottom",
	}))
end
return {
	BorderDistanceBox = BorderDistanceBox,
}
