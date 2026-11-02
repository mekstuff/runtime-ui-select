--[[
    Typed with ❤️ @mekstuff
    17/12/2024 23:39:56
]]

local internal = (((script.Parent :: Instance).Parent :: Instance).Parent :: Instance):FindFirstChild("internal") :: Instance
local internal_functions = internal:FindFirstChild("functions") :: Instance

local RequireTS = require(internal_functions:FindFirstChild("RequireTS")).RequireTS
local PseudoNext = require(((script.Parent :: Instance).Parent :: Instance):WaitForChild("Pseudo"):WaitForChild("PseudoNext")).PseudoNext

-- local threader = RequireTS(internal.Parent.Parent.Parent:FindFirstChild("threader"):FindFirstChild("out")).threader

local PseudoCollector = RequireTS(internal_functions:FindFirstChild("GetPseudoById")).PseudoCollector
local DestroyOnObject = RequireTS(internal_functions:FindFirstChild("DestroyOnObject")).DestroyOnObject
local PseudoPointerStringRef = RequireTS(internal_functions:FindFirstChild("PseudoPointerStringRef"))

local debugModule = RequireTS(internal:FindFirstChild("debug"):FindFirstChild("debug"))
local errorp, warnp = debugModule.errorp, debugModule.warnp

-- Servant Next, Built in luau for better core optimization.
-- ServantNext is seperate from PseudoNext/Pseudo for optimization purposes, but has similar characteristics.

type ServantNext = {
	_ServantDestroyed: boolean?,
} & any

--> Servant Next.
local ServantNext: ServantNext = {
	Name = "Servant",
	ClassName = "Servant",
	_ServantDestroyed = nil,
}

-- Metamethods (We do not use __newindex and __index for Servants (inheriting Pseudo) as they are created alot and performance is expected to be extremely optimized)
-- However PseudoNext is an __index of ServantNext to support some Pseudo methods.
ServantNext.__index = function(self, k: any)
	if k == "Destroying" then
		return PseudoNext.__index(self, "Destroying")
	end
	return (ServantNext :: any)[k] or PseudoNext[k]
end
-- ServantNext.__tostring = PseudoNext.__tostring

function ServantNext:Execute(Func: (...any) -> any): nil -- typeof(threader)
	error("ServantNext:Execute is disabled as threader's are being removed.")
	return nil
	-- local thread = threader.new(Func, nil, true)
	-- thread.active = true
	-- return self:Keep(thread)
end

function ServantNext:Keep(TrackId: any, ...: any): { any } | any
	local Items = { ... }
	if self._ServantDestroyed == true then
		warnp(`new Trackable items will be dropped instantly as the Servant was Destroyed prior to the requests.`)
		if typeof(TrackId) ~= "string" then
			self:_DestroyTrackedItem(TrackId)
		end
		for _, Item in Items do
			self:_DestroyTrackedItem(Item)
		end
		return
	end
	for _, Item in Items do
		self:_AddTrackableItem(Item, if typeof(TrackId) == "string" then TrackId else nil)
	end
	if typeof(TrackId) ~= "string" then
		self:_AddTrackableItem(TrackId, nil)
	end
	if typeof(TrackId) == "string" then
		return ...
	end
	return TrackId, ...
end

function ServantNext:Free(...: any)
	if self._ServantDestroyed or self._dev == nil then
		return
	end
	for _, v in { ... } do
		if typeof(v) == "string" then
			self._dev[v] = nil
		else
			for a, b in self._dev do
				if b == v then
					self._dev[a] = nil
					break
				end
			end
		end
	end
end

function ServantNext:Purge(...: any)
	if self._ServantDestroyed or self._dev == nil then
		return
	end
	for _, v in { ... } do
		if typeof(v) == "string" then
			self:_DestroyTrackedItem(self._dev[v])
			self._dev[v] = nil
		else
			for a, b in self._dev do
				if b == v then
					self:_DestroyTrackedItem(v)
					self._dev[a] = nil
					break
				end
			end
		end
	end
end

function ServantNext:Clean()
	errorp("Cleaning a Servant should not be done in ServantNext, View docs for more information.")
end

function ServantNext:Destroy()
	if self._ServantDestroyed == true then
		return
	end
	local HasDestroyingSignal = self._dev
		and self._dev._signals
		and self._dev._signals.Destroying

	if HasDestroyingSignal then
		HasDestroyingSignal:Fire()
	end

	if self:_HasInternalID() == true then
		--> Remove from PseudoCollector, only if the ID was generated previously.
		PseudoCollector[self:_GetInternalID()] = nil
	end

	self._ServantDestroyed = true
	if self._dev ~= nil then
		self._dev._destroyed = true
		DestroyOnObject(self._dev, 3, "[ADD SERVANTNEXT WARN NAME]")
	end
	--[[
	setmetatable(self, nil)
	]]

	table.freeze(self)
end

function ServantNext:_DestroyTrackedItem(Item: any)
	if Item == nil then
		return
	end
	if typeof(Item) == "RBXScriptConnection" then
		Item.Disconnect(Item)
		return
	end
	if typeof(Item) == "Instance" then
		Item:Destroy()
		return
	end
	if Item.Destroy then
		Item.Destroy()
		return
	end
	if Item.Disconnect then
		Item.Disconnect(Item)
		return
	end
end

function ServantNext:_AddTrackableItem(ItemToTrack: any, Id: string?)
	local Item = ItemToTrack
	-- local targetPushValue = Item
	if typeof(Item) == "function" then
		local InitalCallback = Item
		Item = self.Destroying:Connect(function()
			InitalCallback()
		end)
	end
	-- self._dev = self._dev or {}
	if Id then
		self._dev[Id] = Item
	else
		local PseudoPointerRef = PseudoPointerStringRef.CreatePseudoPointerStringRef(ItemToTrack)
		table.insert(self._dev, PseudoPointerRef or Item)
	end
end

function ServantNext.constructor(...: any)
	--> TS Support, constructor is called, class is more than likely extended using roblox-ts.
	errorp(`Servants cannot be extended/inherited.`)
end

function ServantNext.new()
	return setmetatable({
		_dev = {
			OBJECT_PROXY = {},
		},
		--[[
		_dev = setmetatable({
			OBJECT_PROXY = {},
		}, { __mode = "kv" }),
		]]
	}, ServantNext)
end

return {
	ServantNext = ServantNext,
}
