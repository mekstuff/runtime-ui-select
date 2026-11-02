--[[
    Typed with ❤️ @mekstuff
    16/12/2024 17:58:59
]]

-- Pseudo Next, Built in luau for better core optimization.

local RunService = game:GetService("RunService")

local internal = (script.Parent :: any).Parent.Parent:FindFirstChild("internal")
local internal_functions = internal:FindFirstChild("functions")
local internal_proxycreate = internal:FindFirstChild("proxy-create")

local RequireTSModule = require(internal_functions:FindFirstChild("RequireTS"))
local RequireTS = RequireTSModule.RequireTS

--> Imports
local Signal =
	RequireTS((script.Parent :: any).Parent:FindFirstChild("Signal"):FindFirstChild("Signal") :: ModuleScript).Signal
local typeIs = RequireTS(internal_functions:FindFirstChild("typeIs"))._typeIs
local debugModule = RequireTS(internal:FindFirstChild("debug"):FindFirstChild("debug"))
local PseudoCollector = RequireTS(internal_functions:FindFirstChild("GetPseudoById")).PseudoCollector

local PseudoPointerStringRef = RequireTS(internal_functions:FindFirstChild("PseudoPointerStringRef"))

local GetIsValidTransmitterFunctionName =
	RequireTS(internal_functions:FindFirstChild("GetIsValidTransmitterFunctionName")).GetIsValidTransmitterFunctionName

local GetAttributeStringValue =
	RequireTS(internal_functions:FindFirstChild("GetAttributeStringValue")).GetAttributeStringValue
local UpdateAttrValueForPseudoInstance =
	RequireTS(internal_functions:FindFirstChild("UpdateAttrValueForPseudoInstance")).UpdateAttrValueForPseudoInstance

local _PseudoIdentificationAttrServerName =
	RequireTS(internal_functions:FindFirstChild("GetPseudoByObject"))._PseudoIdentificationAttrServerName

local tryUseEffectCleanup = RequireTS(internal_functions:FindFirstChild("CalluseEffectServant")).tryUseEffectCleanup

local CreateServant = RequireTS(internal_proxycreate:FindFirstChild("CreateServant")).CreateServant
local CreatePseudoReplicator =
	RequireTS(internal_proxycreate:FindFirstChild("CreatePseudoReplicator")).CreatePseudoReplicator

local CreateClientReplicator =
	RequireTS(internal_proxycreate:FindFirstChild("CreateClientReplicator")).CreateClientReplicator

local CreatePseudoClientReplicator =
	RequireTS(internal_proxycreate:FindFirstChild("CreatePseudoClientReplicator")).CreatePseudoClientReplicator

local PSEUDO_G = RequireTS(internal_functions:FindFirstChild("PSEUDO_G")).PSEUDO_G
local DestroyOnObject = RequireTS(internal_functions:FindFirstChild("DestroyOnObject")).DestroyOnObject
local GetAbstractPseudoId = RequireTS(internal_functions:FindFirstChild("GetAbstractPseudoId")).GetAbstractPseudoId

local assertp, errorp, logp, warnp = debugModule.assertp, debugModule.errorp, debugModule.logp, debugModule.warnp

local IsClient = RunService:IsClient()

local function GetObjectToParentToForPseudoParentProperty(Value: any): Instance | nil
	if Value == nil then
		return nil
	end
	if typeof(Value) == "Instance" then
		return Value
	end
	if typeIs(Value, "Pseudo") then
		return Value:GetRef()
	end
	return nil
end

--> Types
type Pseudo = {
	_dev: {
		_runtime_debug_info: {
			creationTimestamp: number,
		},
		_signals: { [string]: any }?,
		_observer_servants: { [string]: any }?,
		OBJECT_PROXY: {
			_attr_set_data: { any }?,
			_ref: any?,
			_refType: any?,
			_InternalID: string?,
			_internalObserverDependencyArrayMap: {
				[string]: {
					servant: any,
					callback: (...any) -> any,
					cleanup: any?,
				},
			}?,
			_useIndexAssignmentEntries: { (...any) -> any }?,

			_replicationParams: {
				serializer: any?,
				filter: { string }?,
				filterType: Enum.RaycastFilterType?,
			}?,
			_replicationObserverReady: boolean?,
			_replicationFunctionOverrides: { [string]: any }?,
			_replicationServerFunctions: { (...any) -> any }?,
			_replicationClientFunctions: { (...any) -> any }?,
		},
		_origin: { any },
		_classNames: { string },
		get: any,
		set: any,
		has: any,
		insert: any,
	},
} & any

type ObserverListener = {
	_deps: (...any) -> any,
	_pointer: Pseudo,
}

--> Pseudo Next.
local PseudoNext: Pseudo = {
	_G = PSEUDO_G,
} :: any

-- Public

--> Replication

function PseudoNext:GetServerReplicationId(): string | nil
	if IsClient then
		local ObjectProxy = self._dev.OBJECT_PROXY
		if ObjectProxy == nil then
			return nil
		end
		if ObjectProxy._replicationParams == nil then
			return nil
		end

		if ObjectProxy._replicationIdentifierKey ~= nil then
			return ObjectProxy._replicationIdentifierKey
		end

		local TRIES = 0
		while true do
			local Target = ObjectProxy._replicationIdentifierKey

			if Target ~= nil then
				return Target
			end

			if TRIES == 10 then
				self:warn(
					`Possible Replication Error (Client) GetServerReplicationId() called and _replicationParams, However no _replicationIdentifierKey has been provided. Returning nil.`
				)
				return nil
			end
			task.wait(TRIES / 10)
			TRIES += 1
		end

		return nil
	end
	--> on the server, the ReplicationId will be the same as the Pseudo Id.
	return self:GetIdAsync()
end

function PseudoNext:HasReplicator(): boolean
	local ObjectProxy = self._dev.OBJECT_PROXY
	if ObjectProxy == nil then
		return false
	end
	return ObjectProxy.Replicator ~= nil
end

function PseudoNext:EnableReplication(FilterList: { string }?, FilterType: Enum.RaycastFilterType?)
	local ObjectProxy = self._dev.OBJECT_PROXY

	if ObjectProxy._replicationParams ~= nil then
		self:error(`Replication was already enabled. Attempted to call :EnableReplication() multiple times.`)
	end

	if FilterList ~= nil then
		self:assert(
			typeof(FilterList) == "table",
			`EnableReplication() FilterList expected to be an array, got {typeof(FilterList)}`
		)
	end

	ObjectProxy._replicationParams = {
		filter = FilterList,
		filterType = FilterType,
	}

	if IsClient == true then
		return
	end
	ObjectProxy.Replicator = CreatePseudoReplicator(self) --> Add directly to OBJECTPROXY, fire no events.

	local ServerFunctions = ObjectProxy._replicationServerFunctions
	local ServerPseudoClientReplicator = CreatePseudoClientReplicator(self)
	local ServerReplicatorServant = CreateServant()
	ServerReplicatorServant:Keep(ServerPseudoClientReplicator)
	self._dev.set("_internal_activeServerReplicatorServant", ServerReplicatorServant)

	if ServerFunctions ~= nil then
		for _, func in ServerFunctions do
			if func(ServerReplicatorServant, ServerPseudoClientReplicator) ~= nil then
				self:error(
					`Cleanup from $server is no longer possible. Please use the Servant that is passed as an argument for any cleaning up.`
				)
			end
		end
	end

	ServerReplicatorServant:Keep(self:Observe(function()
		--> for any future "$server" functions that are applied when Replication is already enabled (view PseudoNext.luau __newindex $client/$server)
		local func = self["$server"]
		if func == nil then
			return
		end
		if func(ServerReplicatorServant, ServerPseudoClientReplicator) ~= nil then
			self:error(
				`Cleanup from $client is no longer possible. Please use the Servant that is passed as an argument for any cleaning up.`
			)
		end
	end, { "$server" }))
	self._replicationObserverReady = true
end

--> Deubgging
function PseudoNext:log(...: any)
	return logp(...)
end
function PseudoNext:warn(...: any)
	return warnp(...)
end
function PseudoNext:error(...: any)
	return errorp(...)
end
function PseudoNext:assert(...: any)
	return assertp(...)
end

function PseudoNext:GetIdAsync(): string
	return self:_GetInternalID()
end

function PseudoNext:CreateSignal(SignalName: string): nil
	local _dev = self._dev
	_dev._signals = _dev._signals or {}
	if _dev._signals[SignalName] ~= nil and _dev._signals[SignalName] ~= true then
		return --> The signal was already created.
	end
	_dev._signals[SignalName] = true --> mark as "true" for now so __index knows to create the signal if it were to be indexed. __index will replace "true" with the actual Signal if required.
	return nil
end

function PseudoNext:GetSignal(SignalName: string): typeof(Signal)
	self:CreateSignal(SignalName)
	return self[SignalName] --> Makes __index create the signal if it doesn't exist.
end

function PseudoNext:HasSignal(SignalName: string): boolean
	local _dev = self._dev
	if _dev._signals == nil then
		return false
	end
	return _dev._signals[SignalName] ~= nil
end

-->
function PseudoNext:GetRef(): Instance
	local ObjectProxy = self._dev.OBJECT_PROXY
	local Ref = ObjectProxy._ref
	if Ref ~= nil then
		return Ref
	end
	local TargetRefType = ObjectProxy._refType or "Folder"
	Ref = if typeof(TargetRefType) == "Instance" then TargetRefType else Instance.new(TargetRefType)
	self:assert(
		Ref:GetAttribute(_PseudoIdentificationAttrServerName) == nil,
		`Attempted to create Pseudo on Instance that is already controlled by a Pseudo. ${Ref}`
	)
	ObjectProxy._ref = Ref
	ObjectProxy._refType = nil --> No need to track the ref type further, free memory.
	self._dev._ref = Ref --> So it gets destroyed

	-- Ref:SetAttribute(_PseudoIdentificationAttrServerName, GetAttributeStringValue(self:GetIdAsync()))
	UpdateAttrValueForPseudoInstance(
		ObjectProxy,
		_PseudoIdentificationAttrServerName,
		GetAttributeStringValue(self:GetIdAsync())
	)

	--> Set attributes initially when ref is created
	if RunService:IsStudio() then
		for key, value in ObjectProxy do
			UpdateAttrValueForPseudoInstance(ObjectProxy, key, value)
		end

		--> Update Pseudo whenever attributes changed ( Only in studio )
		Ref.AttributeChanged:Connect(function(attribute)
			-- if attribute == "Name" or attribute == "Parent" then
			-- 	return
			-- end
			ObjectProxy._attr_set_data = ObjectProxy._attr_set_data or {}
			if ObjectProxy._attr_set_data[attribute] ~= nil then
				return
			end
			ObjectProxy._attr_set_data[attribute] = true

			local targetValue = Ref:GetAttribute(attribute)
			if typeof(targetValue) == "InstanceHandle" then
				--> InstanceHandle support 9/11/2026 (fixes bug where self.x might become an InstanceHandle since attributes support it)
				targetValue = targetValue:Wait() and targetValue:Get()
			end
			self[attribute] = targetValue
			ObjectProxy._attr_set_data[attribute] = nil
		end)
	end

	return Ref
end

function PseudoNext:HasRef(): boolean
	local ObjectProxy = self._dev.OBJECT_PROXY
	return ObjectProxy._ref ~= nil
end

function PseudoNext:ObserveTask(Callback: any, dependencies: any?)
	return self:_internalCreateObserver(Callback, dependencies, true)
end

function PseudoNext:Observe(...)
	return self:_internalCreateObserver(...)
end

function PseudoNext:ObserveForEach(Callback, Dependencies)
	local Proxy: { [string]: any } = {}
	local CleanupEntries: { [string]: any } = {}

	local Observer = self:Observe(function(...)
		for _, Dependecy in Dependencies do
			Proxy[Dependecy] = Proxy[Dependecy] or {}
			CleanupEntries[Dependecy] = CleanupEntries[Dependecy] or {}

			local DependencyValue = self[Dependecy]

			if DependencyValue == nil then
				--> property went from {} to nil ?
				for _, cleanup in CleanupEntries[Dependecy] do
					tryUseEffectCleanup(cleanup, true)
				end
				table.clear(CleanupEntries[Dependecy])
				table.clear(Proxy[Dependecy])
				continue
			end

			assertp(
				typeof(DependencyValue) == "table",
				`ObserveForEach() failure on dependency "{Dependecy}". Expected table or nil, got {typeof(
					DependencyValue
				)}`
			)

			for oldkey in Proxy[Dependecy] do
				if DependencyValue[oldkey] == nil then
					tryUseEffectCleanup(CleanupEntries[Dependecy][oldkey], true)
					CleanupEntries[Dependecy][oldkey] = nil
					Proxy[Dependecy][oldkey] = nil
				end
			end

			for key, value in DependencyValue do
				if Proxy[Dependecy][key] ~= value then
					--> update
					tryUseEffectCleanup(CleanupEntries[Dependecy][key])
					CleanupEntries[Dependecy][key] = Callback(key, value, Dependecy)
				end
				Proxy[Dependecy][key] = value
			end
		end
	end, Dependencies)

	Observer:Keep(function()
		for _, CleanupList in CleanupEntries do
			for _, CleanupEntry in CleanupList do
				tryUseEffectCleanup(CleanupEntry, true)
			end
		end
	end)

	return Observer
end

function PseudoNext:ObserveNow(Callback: any, dependencies: any?)
	warn(`"ObserveNow" will do the same as "Observe", "Observe" executes on the same thread immediately.`)
	return self:Observe(Callback, dependencies)
	-- return self:_internalCreateObserver(Callback, dependencies, true)
end

function PseudoNext:ObserveOnce(Callback: any, dependencies: any?)
	local Observer
	Observer = self:ObserveNext(function(...)
		Callback(...)
		if Observer.Destroy == nil then
			return
		end
		Observer:Destroy()
	end, dependencies)
	return Observer
end

function PseudoNext:ObserveNext(Callback: any, dependencies: any?, CallbackQueue: number?)
	CallbackQueue = CallbackQueue or 1

	local TotalExecutions = 0
	return self:Observe(function(...: any)
		if TotalExecutions >= CallbackQueue then
			return Callback(...)
		end
		TotalExecutions += 1
		return
	end, dependencies)
end

function PseudoNext:useBindingEffect(Properties: { string }, Dependencies: { any })
	local DynamicallyMappedProps = {}
	local InvertedProperties = {}
	for _, Property in Properties do
		if typeof(Property) == "table" then
			for key, value in Property do
				table.insert(InvertedProperties, {
					[value] = key,
				})
				DynamicallyMappedProps[value] = key
			end
		else
			table.insert(InvertedProperties, Property)
		end
	end
	local MappingServant = self:useMappingEffect(Properties, Dependencies)
	for _, Dependecy in Dependencies do
		if typeof(Dependecy) == "Instance" then
			--> Properties from Instances binded to Pseudo.
			MappingServant:Keep((Dependecy :: Instance).Changed:Connect(function(property)
				property = if (Dependecy :: Instance):IsA("ValueBase") then "Value" else property
				if DynamicallyMappedProps[property] then
					self[DynamicallyMappedProps[property]] = Dependecy[property]
					return
				end
				if table.find(Properties, property) then
					self[property] = Dependecy[property]
				end
			end))
		else
			--> Properties from Pseudo binded to Pseudo.
			MappingServant:Keep(Dependecy:useMappingEffect(InvertedProperties, { self }))
		end
	end
	return MappingServant
end

function PseudoNext:useMappingEffect(Properties: { string }, Dependencies: { any })
	local Map = {}
	local ObservePropertiesArray: { string } = {}

	local function assetMapConflict(key: string)
		assert(Map[key] == nil, `Key conflict: "{key}" was already mapped to useMappingEffect property list.`)
	end

	for _, Property in Properties do
		if typeof(Property) ~= "table" then
			assetMapConflict(Property)
			Map[Property] = Property
			table.insert(ObservePropertiesArray, Property)
		else
			for key, value in pairs(Property) do
				assetMapConflict(key)
				assert(
					typeof(key) == "string",
					`Dynamically Mapped Property[1] not a string, got {typeof(Property[1])}`
				)
				assert(
					typeof(value) == "string",
					`Dynamically Mapped Property[2] not a string, got {typeof(Property[2])}`
				)
				Map[key] = value
				table.insert(ObservePropertiesArray, key)
			end
		end
	end

	return self:Observe(function()
		for SelfKey, MappedKey in Map do
			for _, Dependecy in Dependencies do
				local s, r = pcall(function()
					Dependecy[MappedKey] = self[SelfKey]
				end)
				if s ~= true then
					self:warn(`Failed to map property "{MappedKey}" ({SelfKey}) to {Dependecy}. {r}`)
				end
			end
		end
	end, ObservePropertiesArray)
end

-->
function PseudoNext:Destroy(): nil
	if self._dev == nil then
		return
	end
	if self._dev._destroyed == true then
		return
	end
	if self:HasSignal("Destroying") then
		self:GetSignal("Destroying"):Fire()
	end
	if self:_HasInternalID() == true then
		--> Remove from PseudoCollector, only if the ID was generated previously.
		PseudoCollector[self:_GetInternalID()] = nil
	end

	if self._dev.OBJECT_PROXY ~= nil then
		local _ref = self._dev.OBJECT_PROXY._ref
		if _ref ~= nil then
			_ref:Destroy()
		end
		table.clear(self._dev.OBJECT_PROXY)
	end

	self._dev.OBJECT_PROXY = nil --> Remove the OBJECT_PROXY from _dev since _dev will be cleaned up.
	DestroyOnObject(self._dev, 10, "[ADD PSEUDONEXT WARN NAME]") --> TODO: Lower traverse value for optimization purposes/figure a different more optimized method. to cleanup _dev

	-- setmetatable(self, nil)
	self._dev.set = nil
	self._dev.get = nil
	self._dev.has = nil
	self._dev.insert = nil
	self._dev._destroyed = true
	-- self._classNames = nil
	-- self._origin = nil

	--[[
	setmetatable(self, nil)
	table.clear(self)
	table.freeze(self)
	]]

	--[[
	self._dev._destroyed = true
	table.freeze(self)
	]]

	return nil
end

function PseudoNext:useDestroying(callback: (...any) -> any)
	local DestroyingServant = CreateServant()
	if self._dev._destroyed == true then
		callback()
		DestroyingServant:Destroy()
	else
		DestroyingServant:Keep(self.Destroying:Connect(function()
			callback()
			DestroyingServant:Destroy()
		end))
	end
	return DestroyingServant
end

function PseudoNext:IsDestroyed(): boolean
	if self._dev == nil or self._dev._destroyed == true then
		return true
	end
	return false
end

-->
function PseudoNext:CreateServantAsync()
	return CreateServant()
end

-->
function PseudoNext:IsA(ClassName: string): boolean
	if ClassName == "Pseudo" then
		return true
	end
	-- warnp("TODO: Finish adding support for other classnames/inherited classnames for PseudoNext:IsA")
	if ClassName == self.ClassName then
		return true
	end

	local ObjectProxy = self._dev.OBJECT_PROXY
	if ObjectProxy == nil then
		return false
	end

	if self._classNames == nil then
		return false
	end

	return if table.find(self._classNames, ClassName) then true else false
end

-->
function PseudoNext:GetPropertyChangedSignal(PropertyName: string): typeof(Signal)
	return self:GetSignal(`_internal_propertychanged_{PropertyName}`)
end

-->

function PseudoNext:useIndexAssignment(callback: (key: any, value: any) -> any)
	self._dev.OBJECT_PROXY._useIndexAssignmentEntries = self._dev.OBJECT_PROXY._useIndexAssignmentEntries or {}
	table.insert(self._dev.OBJECT_PROXY._useIndexAssignmentEntries, callback)
end

function PseudoNext:useNewIndexAssignment(key, value)
	return getmetatable(self).__newindex(self, key, value, true)
end

function PseudoNext:useAssignReadonlyProperty(Property: any, Value: any)
	self[Property] = Value
end

-- Private
function PseudoNext:_GetInternalID(): string
	local ID = self._dev._InternalID
	if ID ~= nil then
		return ID
	end
	assert(self._dev._destroyed ~= true, "Attempt to _GetInternalID() of a Destroyed Pseudo.")
	ID = GetAbstractPseudoId(self.ClassName)
	self._dev._InternalID = ID --> Cache
	PseudoCollector[ID] = self --> Add from PseudoCollector only when ID is created.
	return ID
end

function PseudoNext:_HasInternalID(): boolean
	if self._dev == nil then
		return false
	end
	if self._dev.OBJECT_PROXY == nil then
		return false
	end
	return self._dev._InternalID ~= nil
end

--[[
	PseudoNext Removed the _runInitialImmediately param and made the ExecutingObserver Servant no longer an argument of callback.
	All for optimization sake.
]]
function PseudoNext:_internalCreateObserver(
	Callback: any,
	dependencies: { any }?,
	executeOnSeperateThread: boolean?
): any
	if typeof(Callback) == "table" then
		return {
			_pseudo = self,
			_deps = Callback,
		}
	end

	local ObserverServant = CreateServant()

	local Cleanups: { any } | nil

	local function RunCleanups(...: any)
		if Cleanups == nil then
			return
		end
		for _, Cleanup in Cleanups do
			tryUseEffectCleanup(Cleanup, ...)
		end
		if Cleanups == nil then
			return
		end
		table.clear(Cleanups)
		Cleanups = nil
	end

	-- TODO: with the executeOnSeperateThread, there's a chance that the initial function doesn't complete before a second call, meaning the cleanup won't be met
	-- same is possible with normal behavior with PropertyChanged. make sure this doesn't happen.
	local function ExecuteCallback(...)
		RunCleanups()
		Cleanups = { Callback(...) }
	end

	if dependencies == nil then
		--> No dependencies, update on every property change.
		ObserverServant:Keep(self.PropertyChanged:Connect(function()
			ExecuteCallback()
		end))
		if executeOnSeperateThread then
			task.spawn(ExecuteCallback)
		else
			ExecuteCallback()
		end
		return ObserverServant
	end

	if #dependencies == 0 then
		--> 0 dependencies, only runs once.
		if executeOnSeperateThread then
			task.spawn(ExecuteCallback)
		else
			ExecuteCallback()
		end
		ObserverServant:Keep(self.Destroying:Connect(function(...)
			RunCleanups(...)
		end))
		return
	end

	for _, v in dependencies do
		if typeof(v) == "table" then
			ObserverServant:Keep(v._pseudo:Observe(ExecuteCallback, v._deps))
			continue
		end
		ObserverServant:Keep(self:GetPropertyChangedSignal(v):Connect(ExecuteCallback))
	end
	if executeOnSeperateThread then
		task.spawn(ExecuteCallback)
	else
		ExecuteCallback()
	end

	ObserverServant._dev._internal_pseudo_cleanup_method_ObserverServant = function()
		RunCleanups(true)
	end

	self._dev._observer_servants = self._dev._observer_servants or {}
	table.insert(self._dev._observer_servants, ObserverServant)
	return ObserverServant

	-- Using GetPropertyChangedSignal ^^ is faster than the concept below:
	--[[
	local ObserverServant = CreateServant()

	local targetDependencyList = dependencies ~= nil and {}
	local targetObserverDependencyList: {
		_pseudo: any,
		dependencies: typeof(dependencies),
	} | nil = nil
	for _, v in dependencies do
		if typeof(v) == "table" then
			targetObserverDependencyList = targetObserverDependencyList or {}
			table.insert(targetObserverDependencyList, v)
			table.insert(targetDependencyList, v._pseudo:GetIdAsync() .. GetDependencyArrayId(v)) --> add to the targetDependencyList so that the DependencyArrayId will also include this unique item.
			continue
		end
		table.insert(targetDependencyList, v)
	end

	local DependencyArrayId = GetDependencyArrayId(targetDependencyList)
	self._dev.OBJECT_PROXY._internalObserverDependencyArrayMap = self._dev.OBJECT_PROXY._internalObserverDependencyArrayMap
		or {}

	local function ExecuteCallback(Entry: {
		servant: any,
		callback: (...any) -> any,
		cleanup: any?,
	})
		if Entry.cleanup ~= nil then --> Shouldn't happen since PrePropertyChanged should run the cleanup, but just incase.
			tryUseEffectCleanup(Entry.cleanup)
			Entry.cleanup = nil
		end
		Entry.cleanup = Entry.callback()
	end

	local _internalObserverDependencyArrayMap = self._dev.OBJECT_PROXY._internalObserverDependencyArrayMap

	if _internalObserverDependencyArrayMap[DependencyArrayId] == nil then
		--> First time use of the specific DependencyArrayId, only create the thread and initialize here.
		_internalObserverDependencyArrayMap[DependencyArrayId] = {}

		if targetObserverDependencyList then
			local ObserverDepedencyListServant = CreateServant()

			_internalObserverDependencyArrayMap[DependencyArrayId]._ObserverDepedencyListServant =
				ObserverDepedencyListServant

			for _, ObserverListenerEntry in targetObserverDependencyList do
				ObserverDepedencyListServant:Keep(
					ObserverListenerEntry._pseudo:ObserveNext(Callback, ObserverListenerEntry._deps)
				)
			end
		end

		local PrePropertyChangedConnection = self.PrePropertyChanged:Connect(function(PropertyName)
			if targetDependencyList and table.find(targetDependencyList, PropertyName) == nil then
				return
			end
			for _, v in _internalObserverDependencyArrayMap[DependencyArrayId] do
				if typeof(v) == "table" and v.cleanup then
					tryUseEffectCleanup(v.cleanup)
					v.cleanup = nil
				end
			end
		end)
		local PropertyChangedConnection = self.PropertyChanged:Connect(function(PropertyName)
			if targetDependencyList and table.find(targetDependencyList, PropertyName) == nil then
				return
			end
			for _, v in _internalObserverDependencyArrayMap[DependencyArrayId] do
				if typeof(v) ~= "table" then
					continue
				end
				if v.callback == nil then
					continue
				end
				ExecuteCallback(v)
			end
		end)

		_internalObserverDependencyArrayMap[DependencyArrayId]._PrePropertyChangedConnection =
			PrePropertyChangedConnection
		_internalObserverDependencyArrayMap[DependencyArrayId]._PropertyChangedConnection = PropertyChangedConnection
	end

	_internalObserverDependencyArrayMap[DependencyArrayId]._total = if _internalObserverDependencyArrayMap[DependencyArrayId]._total
		then _internalObserverDependencyArrayMap[DependencyArrayId]._total + 1
		else 1

	local Entry = {
		servant = ObserverServant, --> So it gets cleaned up of "this" is destroyed. || Save ~.2 seconds some time by excluding this...
		callback = Callback,
		cleanup = nil,
	}

	self._dev.insert(ObserverServant) --> Faster than saving the servant within "Entry"

	ExecuteCallback(Entry)

	-- Servants don't have a Destroying event, bind to the unique matcher key that `DestroyOnObject` supports "_internal_pseudo_cleanup_method"
	ObserverServant._dev._internal_pseudo_cleanup_method_ObserverServant = function()
		if Entry.cleanup then
			tryUseEffectCleanup(Entry.cleanup)
			Entry.cleanup = nil
		end
		if _internalObserverDependencyArrayMap[DependencyArrayId] then
			local foundInEntry = table.find(_internalObserverDependencyArrayMap[DependencyArrayId], Entry)
			if foundInEntry == nil then
				return
			end
			table.remove(_internalObserverDependencyArrayMap[DependencyArrayId], foundInEntry)
			_internalObserverDependencyArrayMap[DependencyArrayId]._total -= 1

			if _internalObserverDependencyArrayMap[DependencyArrayId]._total == 0 then
				_internalObserverDependencyArrayMap[DependencyArrayId]._PrePropertyChangedConnection:Disconnect()
				_internalObserverDependencyArrayMap[DependencyArrayId]._PropertyChangedConnection:Disconnect()
				if _internalObserverDependencyArrayMap[DependencyArrayId]._ObserverDepedencyListServant ~= nil then
					_internalObserverDependencyArrayMap[DependencyArrayId]._ObserverDepedencyListServant:Destroy()
				end
				_internalObserverDependencyArrayMap[DependencyArrayId] = nil
			end
		end
	end

	return ObserverServant
	]]
end

function PseudoNext:_getCurrentProperties(
	excludeKeys: { any }?,
	IncludeHiddenProps: boolean?,
	IncludeFunctions: boolean?,
	IncludeSignals: boolean?,
	AsDictionary: boolean?
)
	--> Change from Pseudo -> PseudoNext, _getCurrentProperties() is a method and no longer a callback.
	local CurrentProperties = {}
	for key, value in self._dev.OBJECT_PROXY do
		if excludeKeys ~= nil and table.find(excludeKeys, key) ~= nil then
			continue
		end
		if typeof(key) == "string" and IncludeHiddenProps ~= true and key:match("^_") ~= nil then
			continue
		end
		if typeof(value) == "function" and IncludeFunctions ~= true then
			continue
		end
		if typeof(value) == "RBXScriptSignal" and IncludeSignals ~= true then
			continue
		end
		if typeIs(value, "Signal") and IncludeSignals ~= true then
			continue
		end

		if AsDictionary then
			CurrentProperties[key] = value
		else
			table.insert(CurrentProperties, key)
		end
	end
	return CurrentProperties
end

--> Metamethods.
PseudoNext.__tostring = function(self)
	return `{self.ClassName}({self.Name}) ++ {self:GetIdAsync()}{if self:IsDestroyed() then " *Destroyed*" else ""}`
end
PseudoNext.__index = function(self: Pseudo, key: any)
	local ObjectProxy = if self._dev ~= nil then self._dev.OBJECT_PROXY else nil

	--> Parent is not stored within Pseudo/OBJECT_PROXY, we use _ref to track the Parent. If there's no _ref then the Parent must be nil.
	if key == "Parent" then
		local _ref = self._dev.OBJECT_PROXY._ref
		if _ref ~= nil then
			return _ref.Parent
		end
		return nil
	end

	if key == "_id" then
		warnp("It is recommended to use the GetIdAsync() instead of the _id Property.")
		return self:_GetInternalID()
	end

	--> Creating internal events only when required. (return statement below will handle returning the value, just make sure to create it here.)
	if key == "Destroying" then
		self:CreateSignal("Destroying")
	end
	if key == "PrePropertyChanged" then
		self:CreateSignal("PrePropertyChanged")
	end
	if key == "PropertyChanged" then
		self:CreateSignal("PropertyChanged")
	end

	--> indexing Signals
	local IsSignalValue = if ObjectProxy ~= nil and self._dev._signals ~= nil
		then (self._dev._signals :: any)[key]
		else nil
	if IsSignalValue == true then
		--> It's a signal that should exist, create now.
		local Sig = Signal.new();
		(self._dev :: any)._signals[key] = Sig
		return Sig
	elseif IsSignalValue ~= nil then
		--> Already created the signal previously, return.
		return IsSignalValue
	end

	local targetValue
	if ObjectProxy ~= nil and ObjectProxy[key] ~= nil then
		targetValue = ObjectProxy[key]
	elseif self._origin ~= nil and self._origin[key] ~= nil then
		targetValue = self._origin[key]
	else
		targetValue = (PseudoNext :: { any })[key]
	end

	--> override any "Server" or "Client" Replicator functions so we expose the initial arguments to the Replicator
	if
		IsClient == false
		and typeof(key) == "string"
		and typeof(targetValue) == "function"
		and (GetIsValidTransmitterFunctionName(key))
		and ObjectProxy[key] ~= targetValue --> once it is not apart of the ObjectProxy, we can safely assume it was not overriden by the Replicator yet.
	then
		local initialFunc = targetValue
		targetValue = function(...)
			local kid = `Pseudo.ValidReplicatorFuncNameData.{tostring(initialFunc)}`
			_G[kid] = { ... }
			initialFunc(...)
			_G[kid] = nil
		end
	end

	if targetValue == nil and key == "Replicator" then
		if IsClient == true and ObjectProxy._replicationParams ~= nil then
			--> Replication was enable but the script to setup `this` as a replicated class did not run yet
			--> So we set it up here, View Pseudo-Replicator-Client->init.client.lua for more information.
			local Replicator = CreateClientReplicator(self)
			ObjectProxy.Replicator = Replicator
			return Replicator
		end
		self:error(`You need to EnableReplication() before attempting to use .Replicator`)
	end

	--[[
	if
		not IsClient
		and (ObjectProxy._replicationFunctionOverrides == nil or ObjectProxy._replicationFunctionOverrides[key] == nil)
	then
		if
			typeof(targetValue) == "function"
			and typeof(key) == "string"
			and key:match("^%a")
			and key:match("Client$")
		then
			local _sub = (key :: string):sub(1, 1)
			if _sub:lower() == _sub then --> first letter is lowercase.
				local oldFunc = targetValue
				targetValue = function(_, ...)
					oldFunc(self, ...)
				end
				local DefaultTransmitterFunc = ObjectProxy.Replicator.Transmit
				ObjectProxy.Replicator.Transmit = function(_, arg0, func)
					func()
					-- func(1)
					-- DefaultTransmitterFunc()
				end
				ObjectProxy._replicationFunctionOverrides = ObjectProxy._replicationFunctionOverrides or {}
				ObjectProxy._replicationFunctionOverrides[key] = true
			end
		end
	end
	]]

	-- > Allowing change of the index with "useIndexAssignment"
	if ObjectProxy ~= nil and ObjectProxy._useIndexAssignmentEntries ~= nil then
		for _, entry in ObjectProxy._useIndexAssignmentEntries do
			targetValue = entry(key, targetValue)
		end
	end

	return targetValue
end

PseudoNext.__newindex = function(self: Pseudo, key: any, value: any, allowSameValueWrite: boolean?)
	if self._dev and self._dev._destroyed == true then
		return
	end

	local _dev = self._dev
	local ObjectProxy = _dev.OBJECT_PROXY

	if key == "$server" and value ~= nil and IsClient ~= true then
		if ObjectProxy._replicationObserverReady ~= true then
			--> capture "$server" assigments to store for replication
			ObjectProxy._replicationServerFunctions = ObjectProxy._replicationServerFunctions or {}
			table.insert(ObjectProxy._replicationServerFunctions, value)
			-- Since we are returning here, PropertyChanged for "$server" will not fire until _replicationObserverReady is true
			return
			--> else: replication already enabled, call the function (an Observer is listening, so do nothing here.)
		end
	end
	if key == "$client" and value ~= nil and IsClient == true then
		if ObjectProxy._replicationObserverReady ~= true then
			--> capture "$client" assigments to store for replication
			ObjectProxy._replicationClientFunctions = ObjectProxy._replicationClientFunctions or {}
			table.insert(ObjectProxy._replicationClientFunctions, value)
			-- Since we are returning here, PropertyChanged for "$client" will not fire until _replicationObserverReady is true
			return
			--> else: replication already enabled, call the function (an Observer is listening, so do nothing here.)
		end
	end

	if key ~= "Parent" and ObjectProxy[key] == value and allowSameValueWrite ~= true then
		return --> Same value, no change/render/events should be fired atp.
	end

	if key == "ClassName" and ObjectProxy.ClassName ~= nil then
		table.insert(self._classNames, value)
	end

	local ObjectSignals = _dev._signals --> So we don't use any api methods, faster indexing?

	--> Fire PrePropertyChanged and PropertyChanged Signals.
	if key ~= "PrePropertyChanged" and ObjectSignals ~= nil and ObjectSignals.PrePropertyChanged ~= nil then
		self:GetSignal("PrePropertyChanged"):Fire(key, value)
	end

	--> Parent is not stored within Pseudo/OBJECT_PROXY, we use _ref to track the Parent. If there's no _ref then the Parent must be nil.
	if key == "Parent" then
		local _ref = ObjectProxy._ref
		if _ref ~= nil then
			_ref.Parent = GetObjectToParentToForPseudoParentProperty(value)
		else
			-- only create ref once "Parent" is not nil.
			local Ref = self:GetRef()
			Ref.Name = ObjectProxy.Name
			Ref.Parent = GetObjectToParentToForPseudoParentProperty(value)
		end
	else
		ObjectProxy[key] = value --> Change value in the ObjectProxy (update the value.)
		if key == "Name" and ObjectProxy._ref ~= nil then
			ObjectProxy._ref.Name = value --> Update the "Name" if Ref only if Ref was created.
		end
	end

	-- Fire any GetPropertyChangedSignal
	local GetPropertyChangedSignalName = `_internal_propertychanged_{key}`
	if
		key ~= GetPropertyChangedSignalName
		and ObjectSignals ~= nil
		and ObjectSignals[GetPropertyChangedSignalName] ~= nil
	then
		self:GetSignal(GetPropertyChangedSignalName):Fire(value)
	end
	--> Fire PropertyChanged Signals.
	if key ~= "PropertyChanged" and ObjectSignals ~= nil and ObjectSignals.PropertyChanged ~= nil then
		self:GetSignal("PropertyChanged"):Fire(key, value)
	end

	UpdateAttrValueForPseudoInstance(ObjectProxy, key, value)
end

PseudoNext.__call = function(self: Pseudo, ...)
	if self.__metamethod_call == nil then
		self:error(`__metamethod_call not assigned to {self}, cannot PseudoNext() on object.`)
		return
	end
	return self.__metamethod_call(self, ...)
end

--> Main class logic
local function SetupPseudoAsync(self: Pseudo, ClassName: string, ReferenceInstanceType: any?)
	self._dev = {
		OBJECT_PROXY = {
			_refType = ReferenceInstanceType,
		},
		has = function(key)
			if self._dev == nil then
				return
			end
			return (self._dev :: any)[key] ~= nil
		end,
		set = function(key: any, value: any)
			if self._dev == nil then
				return
			end
			--> Pseudo's in _dev are stored as PointerStringRefs, This is an optimization and it recommended to use set() and get() when working with Pseudo's in _dev.
			local PseudoPointerRef = if typeof(value) == "string"
				then PseudoPointerStringRef.CreatePseudoPointerStringRef(value)
				else nil
			(self._dev :: any)[key] = PseudoPointerRef or value
		end,
		get = function(key: any)
			if self._dev == nil then
				return
			end
			local TargetValue = (self._dev :: any)[key]
			local PseudoFromPointerRef = if typeof(TargetValue) == "string"
				then PseudoPointerStringRef.GetPseudoFromPointerStringRef(TargetValue)
				else nil
			return PseudoFromPointerRef or TargetValue
		end,
		insert = function(item: any)
			if self._dev == nil then
				return
			end
			local PseudoPointerRef = PseudoPointerStringRef.CreatePseudoPointerStringRef(item)
			table.insert(self._dev, PseudoPointerRef or item)
		end,
		--[[ RUNTIME DEBUGGER DISABLED
		_internal_runtime_debug_info = {
			creationTimestamp = DateTime.now().UnixTimestamp,
		}
		]]
	} :: any

	-- local originMetatable = getmetatable(self)
	self._origin = getmetatable(self)
	self._classNames = {}

	setmetatable(self :: { any }, PseudoNext)
	self.Name = ClassName
	self.ClassName = ClassName

	-- self:GetIdAsync()
end

function PseudoNext.constructor(...: any)
	--> TS Support, constructor is called, class is more than likely extended using roblox-ts.
	return SetupPseudoAsync(...)
end

function PseudoNext.new()
	errorp(`PseudoNext is an abstract class and can only be inherited.`)
end

return {
	PseudoNext = PseudoNext,
}
