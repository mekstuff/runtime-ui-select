-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local _vivid = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "vivid").out)
local Vivid = _vivid.default
local createEffect = _vivid.createEffect
local createState = _vivid.createState
local For = _vivid.For
local Show = _vivid.Show
local use = _vivid.use
local function createTabRoute(defaultRoute)
	return {
		_defaultRoute = defaultRoute,
		_history = nil,
		clearHistory = nil,
		jumpTo = nil,
		goBack = nil,
	}
end
local function Tabs(props)
	local currentTab, setCurrentTab, currentTabState = createState(props.route._defaultRoute)
	-- setting up TabRoute
	props.route._history = if currentTabState.State ~= nil then { currentTabState.State } else {}
	local addToTabRouteHistory = function(target)
		local __history = props.route._history
		local _target = target
		table.insert(__history, _target)
	end
	local removeFirstFromTabRouteHistory = function(target)
		local __history = props.route._history
		local __history_1 = props.route._history
		local _target = target
		local _arg0 = (table.find(__history_1, _target) or 0) - 1
		table.remove(__history, _arg0 + 1)
	end
	props.route.clearHistory = function()
		table.clear(props.route._history)
	end
	props.route.jumpTo = function(target, ignoreHistory)
		setCurrentTab(target)
		if ignoreHistory ~= true then
			addToTabRouteHistory(target)
		end
		return true
	end
	props.route.goBack = function()
		local previousRoute = props.route._history[#props.route._history - 1]
		if previousRoute ~= nil then
			removeFirstFromTabRouteHistory(previousRoute)
			props.route.jumpTo(previousRoute)
		end
		return true
	end
	createEffect(function()
		local currTab = currentTab()
		if not (currTab ~= "" and currTab) then
			return nil
		end
		if props.tabs[currTab] then
			return nil
		end
		warn(`tab "{currTab}" doesn't exist within tabs list - History: {table.concat(props.route._history, ",")}.`)
	end)
	return Vivid.createElement("frame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
	}, Vivid.createElement(For, {
		each = props.tabs,
		uniqueIdExtractor = function(_, key)
			return key
		end,
		children = function(item, _, uid)
			local tabPosition, setTabPosition = createState(UDim2.new())
			createEffect(function()
				setTabPosition(if currentTab() == uid then UDim2.new() else UDim2.new(-1, 0, 0, 0))
			end)
			return Vivid.createElement("frame", {
				Size = UDim2.fromScale(1, 1),
				Position = tabPosition(),
				BackgroundTransparency = 0.5,
			}, Vivid.createElement(Show, {
				when = createEffect(function()
					return currentTab() == uid
				end),
				children = use(function()
					return item.content
				end),
			}))
		end,
	}))
end
return {
	createTabRoute = createTabRoute,
	Tabs = Tabs,
}
