-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    05/06/2025 13:52:40
	
]]
local PseudoCollector = TS.import(script, script.Parent.Parent.Parent, "internal", "functions", "GetPseudoById").PseudoCollector
local _typeIs = TS.import(script, script.Parent.Parent.Parent, "internal", "functions", "typeIs")._typeIs
local Pseudo = TS.import(script, script.Parent.Parent, "Pseudo", "Pseudo").Pseudo
local RuntimeDebuggerRoot = TS.import(script, script.Parent, "RuntimeDebuggerRoot").RuntimeDebuggerRoot
local Players = game:GetService("Players")
local ContextActionService = game:GetService("ContextActionService")
local RuntimeDebugger
do
	local super = Pseudo
	RuntimeDebugger = setmetatable({}, {
		__tostring = function()
			return "RuntimeDebugger"
		end,
		__index = super,
	})
	RuntimeDebugger.__index = RuntimeDebugger
	function RuntimeDebugger.new(...)
		local self = setmetatable({}, RuntimeDebugger)
		return self:constructor(...) or self
	end
	function RuntimeDebugger:constructor(TargetClient)
		super.constructor(self, "RuntimeDebugger")
		self.MainWindowOpened = false
		self.PseudoEntiresDebuggerOpened = false
		self.ServerSectionCollapsed = false
		self.ClientSharedPseudoCollectorServerFetched = {}
		self["$server"] = function(_, PCR)
			self._PCR = PCR
			self.RuntimeDebuggerRoot = RuntimeDebuggerRoot.new(self)
			self._dev.insert(self.RuntimeDebuggerRoot)
			local GetRuntimeDebuggerSharedPseudoCollector = PCR:CreateRemote("GetRuntimeDebuggerSharedPseudoCollector")
			GetRuntimeDebuggerSharedPseudoCollector.OnServerEvent:Connect(function()
				if self.RuntimeDebuggerRoot:GetIsVerifiedUsageUser(TargetClient) == false then
					return nil
				end
				GetRuntimeDebuggerSharedPseudoCollector:FireClient(TargetClient, self.RuntimeDebuggerRoot.SharedPseudoCollector or {})
			end)
			self.RuntimeDebuggerRoot:ObserveNext(function()
				GetRuntimeDebuggerSharedPseudoCollector:FireClient(TargetClient, self.RuntimeDebuggerRoot.SharedPseudoCollector or {})
			end, { "SharedPseudoCollector" })
			PCR:InitializeClients(script, { TargetClient })
		end
		self["$client"] = function(_, PCR)
			self._PCR = PCR
			local IrisModule = TS.Promise.new(function(resolve)
				resolve(TS.import(script, TS.getModule(script, "@rbxts", "iris").src))
			end):expect()
			local RuntimeDebuggerScreenGui = Instance.new("ScreenGui")
			RuntimeDebuggerScreenGui.Name = `{self:GetIdAsync()}-ScreenGui`
			RuntimeDebuggerScreenGui.IgnoreGuiInset = true
			local Iris = IrisModule.Init(RuntimeDebuggerScreenGui)
			self:PseudoEntriesModifierWindow(Iris)
			self:PowerHorseEngineDebuggerWindow(Iris)
			RuntimeDebuggerScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
			local GetRuntimeDebuggerSharedPseudoCollector = PCR:GetRemote("GetRuntimeDebuggerSharedPseudoCollector")
			GetRuntimeDebuggerSharedPseudoCollector.OnClientEvent:Connect(function(Data)
				self.ClientSharedPseudoCollectorServerFetched = Data
			end)
			self:Observe(function()
				if self.ServerSectionCollapsed == true then
					return nil
				end
				self:addRuntimeDebuggerRootUsageServer():andThen(function()
					return self:RunGetRuntimeDebuggerSharedPseudoCollector()
				end)
				return function()
					self:removeRuntimeDebuggerRootUsageServer()
				end
			end, { "ServerSectionCollapsed" })
			local ToggleOpenedActionId = `{self:GetIdAsync()}-ToggleOpened`
			ContextActionService:BindActionAtPriority(ToggleOpenedActionId, function(_, State)
				if State ~= Enum.UserInputState.Begin then
					return nil
				end
				self.MainWindowOpened = not self.MainWindowOpened
			end, false, 99, Enum.KeyCode.LeftShift)
		end
		self:EnableReplication({}, Enum.RaycastFilterType.Include)
	end
	function RuntimeDebugger:toNumberCommas(value)
		local str = tostring(value)
		local _exp = string.reverse(str)
		local _arg2 = math.floor((#str - 1) / 3)
		return string.reverse((string.gsub(_exp, "...", "%0,", _arg2)))
	end
	function RuntimeDebugger:RunGetRuntimeDebuggerSharedPseudoCollector()
		local GetRuntimeDebuggerSharedPseudoCollector = self._PCR:GetRemote("GetRuntimeDebuggerSharedPseudoCollector")
		GetRuntimeDebuggerSharedPseudoCollector:FireServer()
	end
	function RuntimeDebugger:addRuntimeDebuggerRootUsageServer(...)
		local args = { ... }
		return self.Replicator:Define(function(Player)
			self.RuntimeDebuggerRoot:AddUserUsage(Player)
		end, unpack(args))
	end
	function RuntimeDebugger:removeRuntimeDebuggerRootUsageServer(...)
		local args = { ... }
		return self.Replicator:Define(function(Player)
			self.ClientSharedPseudoCollectorServerFetched = {}
			self.RuntimeDebuggerRoot:RemoveUserUsage(Player)
		end, unpack(args))
	end
	function RuntimeDebugger:PowerHorseEngineDebuggerWindow(Iris)
		Iris:Connect(function()
			local Window = Iris.Window({ "PowerHorse Engine", nil, nil, nil, true })
			Window.state.isOpened:set(self.MainWindowOpened)
			if Window.state.isOpened.value and Window.state.isUncollapsed.value then
				do
					Iris.SeparatorText({ "Debuggers" })
					Iris.SameLine({})
					do
						Iris.Text({ "Pseudo Entries" })
						if Iris.Button({ if self.PseudoEntiresDebuggerOpened == true then "Close" else "Open" }).clicked() == true then
							self.PseudoEntiresDebuggerOpened = not self.PseudoEntiresDebuggerOpened
						end
					end
					Iris.End()
				end
			end
			Iris.End()
		end)
	end
	function RuntimeDebugger:PseudoEntriesModifierWindow(Iris)
		local BRICK_COLORS = {}
		for a, b in pairs(BrickColor) do
			if a == "new" or a == "palette" then
				continue
			end
			table.insert(BRICK_COLORS, b)
		end
		local CreateModifierWindow = function(Info, PseudosList, Props)
			local CollapsingHeader = Iris.CollapsingHeader({ `{Info.Name} ({Info.Id}) "{Info.DisplayName}"` })
			local _result = Props
			if _result ~= nil then
				_result = _result.OnSectionCollapsed
			end
			if _result ~= nil then
				if CollapsingHeader.collapsed() then
					Props.OnSectionCollapsed()
				end
			end
			local _result_1 = Props
			if _result_1 ~= nil then
				_result_1 = _result_1.OnSectionUnCollapsed
			end
			if _result_1 ~= nil then
				if CollapsingHeader.uncollapsed() then
					Props.OnSectionUnCollapsed()
				end
			end
			local PseudoListArray = {}
			for _, PseudoObject in pairs(PseudosList) do
				table.insert(PseudoListArray, PseudoObject)
			end
			table.sort(PseudoListArray, function(a, b)
				return string.lower(a.Name) < string.lower(b.Name)
			end)
			local SortedPseudoObjects = PseudoListArray
			local TotalPseudos = #SortedPseudoObjects
			do
				Iris.Text({ `Total Pseudo's: ({self:toNumberCommas(TotalPseudos)})` })
				-- Iris.Text([`Total Pseudo RBX Connections: (${this.toNumberCommas(TotalPseudoConnections)})`]);
				-- let TotalPseudoConnectionsThisFrame = 0;
				for _, PseudoObject in pairs(SortedPseudoObjects) do
					local PseudoId = if PseudoObject._dev and PseudoObject._dev.get then PseudoObject._dev.get("_InternalID") else ""
					local PseudoObjectMutatable = PseudoObject
					local PropertiesEntries = {}
					local PrivatePropertiesEntries = {}
					local MethodEntries = {}
					local PrivateMethodEntries = {}
					local SignalEntries = {}
					local PrivateSignalEntries = {}
					local ConnectionEntries = {}
					local _devEntries = {}
					for _devProp, _devValue in pairs(PseudoObject._dev) do
						local _arg0 = {
							Key = tostring(_devProp),
							Value = _devValue,
						}
						table.insert(_devEntries, _arg0)
					end
					local HandleInputEntries = function(Entries, EntriesName)
						Iris.Tree({ `{EntriesName} ({self:toNumberCommas(#Entries)})` })
						do
							-- ▼ ReadonlyArray.forEach ▼
							local _callback = function(EntryValue)
								Iris.SeparatorText({ EntryValue.Key })
								-- BrickColors
								local _value = EntryValue.Value
								if typeof(_value) == "BrickColor" then
									local BrickColorState = Iris.State(EntryValue.Value)
									local Combo = Iris.Combo({ "" }, {
										index = BrickColorState,
									})
									do
										-- ▼ ReadonlyArray.forEach ▼
										local _callback_1 = function(BrickColorFunc)
											local TargetBrickColor = BrickColorFunc()
											Iris.Selectable({ TargetBrickColor.Name, TargetBrickColor.Name }, {
												index = BrickColorState,
											})
										end
										for _k, _v in BRICK_COLORS do
											_callback_1(_v, _k - 1, BRICK_COLORS)
										end
										-- ▲ ReadonlyArray.forEach ▲
									end
									Iris.End()
									if Combo.closed() == true then
										PseudoObjectMutatable[EntryValue.Key] = BrickColor.new(Combo.state.index.value)
									end
									return nil
								end
								-- CFrame
								local _value_1 = EntryValue.Value
								if typeof(_value_1) == "CFrame" then
									local CFPos = Iris.InputVector3({ "Position" }, {
										number = EntryValue.Value.Position,
									})
									local RotationX, RotationY, RotationZ = EntryValue.Value:ToEulerAnglesXYZ()
									local CFRot = Iris.InputVector3({ "Rotation" }, {
										number = Vector3.new(RotationX, RotationY, RotationZ),
									})
									if CFPos.numberChanged() == true or CFRot.numberChanged() == true then
										local Rot = CFRot.state.number.value
										local _cFrame = CFrame.new(CFPos.state.number.value)
										local _arg0 = CFrame.Angles(Rot.X, Rot.Y, Rot.Z)
										local NewCF = _cFrame * _arg0
										PseudoObjectMutatable[EntryValue.Key] = NewCF
									end
									return nil
								end
								-- Vector3
								local _value_2 = EntryValue.Value
								if typeof(_value_2) == "Vector3" then
									local Position = Iris.InputVector3({ "" }, {
										number = EntryValue.Value,
									})
									if Position.numberChanged() == true then
										PseudoObjectMutatable[EntryValue.Key] = Position.state.number.value
									end
									return nil
								end
								-- Color3
								local _value_3 = EntryValue.Value
								if typeof(_value_3) == "Color3" then
									local InputColor3 = Iris.InputColor3({ "" }, {
										color = EntryValue.Value,
									})
									if InputColor3.numberChanged() then
										PseudoObjectMutatable[EntryValue.Key] = InputColor3.state.color.value
									end
									return nil
								end
								-- Boolean
								local _value_4 = EntryValue.Value
								if type(_value_4) == "boolean" then
									local Checkbox = Iris.Checkbox({ "" }, {
										isChecked = EntryValue.Value,
									})
									if Checkbox.checked() or Checkbox.unchecked() then
										PseudoObjectMutatable[EntryValue.Key] = Checkbox.state.isChecked.value
									end
									return nil
								end
								-- Number
								local _value_5 = EntryValue.Value
								if type(_value_5) == "number" then
									local InputNum = Iris.InputNum({ "" }, {
										number = EntryValue.Value,
									})
									if InputNum.numberChanged() then
										PseudoObjectMutatable[EntryValue.Key] = InputNum.state.number.value
									end
									return nil
								end
								-- String
								local _value_6 = EntryValue.Value
								if type(_value_6) == "string" then
									local InputText = Iris.InputText({ "" }, {
										text = EntryValue.Value,
									})
									if InputText.textChanged() then
										PseudoObjectMutatable[EntryValue.Key] = InputText.state.text.value
									end
									return nil
								end
								-- Function
								local _value_7 = EntryValue.Value
								if type(_value_7) == "function" then
									Iris.SameLine({})
									do
										Iris.Text({ `{EntryValue.Key}` })
										Iris.Button({ "Invoke Method" })
										Iris.Button({ "Invoke Function" })
									end
									Iris.End()
									return nil
								end
								-- Default
								Iris.Text({ `{EntryValue.Key} = {EntryValue.Value}` })
							end
							for _k, _v in Entries do
								_callback(_v, _k - 1, Entries)
							end
							-- ▲ ReadonlyArray.forEach ▲
						end
						Iris.End()
					end
					Iris.Tree({ `{PseudoObject.Name}` })
					do
						local _result_2 = Props
						if _result_2 ~= nil then
							_result_2 = _result_2.IsServerReplicatedContent
						end
						for _Key, _PseudoProp in pairs(if _result_2 then PseudoObject else (PseudoObject:_getCurrentProperties(nil, true, true, true))) do
							local _result_3 = Props
							if _result_3 ~= nil then
								_result_3 = _result_3.IsServerReplicatedContent
							end
							local PseudoProp = (if _result_3 then _Key else _PseudoProp)
							local _result_4 = Props
							if _result_4 ~= nil then
								_result_4 = _result_4.IsServerReplicatedContent
							end
							local TargetValue = (if _result_4 then _PseudoProp else PseudoObject[PseudoProp])
							local IsPrivateProp = string.sub(PseudoProp, 0, 1) == "_"
							if type(TargetValue) == "function" then
								if IsPrivateProp == false then
									local _arg0 = {
										Key = PseudoProp,
										Value = TargetValue,
									}
									table.insert(MethodEntries, _arg0)
								else
									local _arg0 = {
										Key = PseudoProp,
										Value = TargetValue,
									}
									table.insert(PrivateMethodEntries, _arg0)
								end
								continue
							end
							if typeof(TargetValue) == "RBXScriptConnection" then
								table.insert(ConnectionEntries, TargetValue)
								continue
							end
							if _typeIs(TargetValue, "Signal") then
								if IsPrivateProp == false then
									local _arg0 = {
										Key = PseudoProp,
										Value = TargetValue,
									}
									table.insert(SignalEntries, _arg0)
								else
									local _arg0 = {
										Key = PseudoProp,
										Value = TargetValue,
									}
									table.insert(PrivateSignalEntries, _arg0)
								end
								continue
							end
							if IsPrivateProp == false then
								local _arg0 = {
									Key = PseudoProp,
									Value = TargetValue,
								}
								table.insert(PropertiesEntries, _arg0)
							else
								local _arg0 = {
									Key = PseudoProp,
									Value = TargetValue,
								}
								table.insert(PrivatePropertiesEntries, _arg0)
							end
						end
						Iris.Tree({ "Debug" })
						do
							local _internal_runtime_debug_info = PseudoObject._dev._internal_runtime_debug_info
							Iris.Text({ `UID: {PseudoId}` })
							if _internal_runtime_debug_info ~= nil then
								Iris.Text({ `Uptime: ({self:toNumberCommas(DateTime.now().UnixTimestamp - _internal_runtime_debug_info.creationTimestamp)}) seconds` })
								Iris.Text({ `Created: {DateTime.fromUnixTimestamp(_internal_runtime_debug_info.creationTimestamp):FormatLocalTime("LLLL", "en-us")}` })
							end
						end
						Iris.End()
						HandleInputEntries(PropertiesEntries, "Properties")
						HandleInputEntries(PrivatePropertiesEntries, "Hidden Properties")
						HandleInputEntries(MethodEntries, "Methods")
						HandleInputEntries(PrivateMethodEntries, "Hidden Methods")
						HandleInputEntries(SignalEntries, "Signals")
						HandleInputEntries(PrivateSignalEntries, "Hidden Signals")
						HandleInputEntries(ConnectionEntries, "Connections")
						HandleInputEntries(_devEntries, "_dev")
					end
					Iris.End()
				end
			end
			Iris.End()
		end
		self.ServerSectionCollapsed = true
		local OnServerSectionUnCollapsed = function()
			if self.ServerSectionCollapsed == false then
				return nil
			end
			self.ServerSectionCollapsed = false
		end
		local OnServerSectionCollapsed = function()
			if self.ServerSectionCollapsed == true then
				return nil
			end
			self.ServerSectionCollapsed = true
		end
		Iris:Connect(function()
			local Window = Iris.Window({ "PowerHorse Engine Debugger - Pseudo Entries", nil, nil, nil, true })
			Window.state.isOpened:set(self.PseudoEntiresDebuggerOpened)
			if Window.state.isOpened.value and Window.state.isUncollapsed.value then
				do
					CreateModifierWindow({
						Id = Players.LocalPlayer.UserId,
						Name = Players.LocalPlayer.Name,
						DisplayName = Players.LocalPlayer.DisplayName,
					}, PseudoCollector)
					CreateModifierWindow({
						Id = game.GameId,
						Name = `{game.Name}`,
						DisplayName = `{game.PlaceId}`,
					}, self.ClientSharedPseudoCollectorServerFetched, {
						OnSectionCollapsed = OnServerSectionCollapsed,
						OnSectionUnCollapsed = OnServerSectionUnCollapsed,
						IsServerReplicatedContent = true,
					})
				end
			end
			Iris.End()
		end)
	end
end
return {
	default = RuntimeDebugger,
}
