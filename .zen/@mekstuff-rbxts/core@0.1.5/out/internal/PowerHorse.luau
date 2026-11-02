-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
-- import { threader } from "@mekstuff-rbxts/threader";
local Pseudo = TS.import(script, script.Parent.Parent, "class", "Pseudo", "Pseudo").Pseudo
local Servant = TS.import(script, script.Parent.Parent, "class", "Servant", "Servant").Servant
local Signal = TS.import(script, script.Parent.Parent, "class", "Signal", "Signal").Signal
local Spring = TS.import(script, script.Parent.Parent, "class", "Spring", "Spring").Spring
local State = TS.import(script, script.Parent.Parent, "class", "State", "State").State
local _typeIs = TS.import(script, script.Parent, "functions", "typeIs")._typeIs
local GetPseudoById = TS.import(script, script.Parent, "functions", "GetPseudoById").GetPseudoById
local GetPseudoFromObject = TS.import(script, script.Parent, "functions", "GetPseudoByObject").GetPseudoFromObject
local Engine = TS.import(script, script.Parent.Parent, "class", "Engine", "Engine").Engine
local SpreadOperator = TS.import(script, script.Parent, "functions", "SpreadOperator").default
local RecursiveTry = TS.import(script, script.Parent, "functions", "RecursiveTry").default
local BatchIterate = TS.import(script, script.Parent, "functions", "BatchIterate").default
local color3 = TS.import(script, script.Parent.Parent, "data-types", "Color3", "Color3")
local Compatibility = TS.import(script, script.Parent.Parent, "class", "Compatibility", "Compatibility").default
local Observables = TS.import(script, script.Parent.Parent, "class", "Observables", "Observables").default
local RuntimeDebugger = TS.import(script, script.Parent.Parent, "class", "RuntimeDebugger", "RuntimeDebugger").default
local InstanceMapper = TS.import(script, script.Parent.Parent, "class", "InstanceMapper", "InstanceMapper").default
-- import Syncer from "../class/Replication/Syncer";
local Debouncer = TS.import(script, script.Parent.Parent, "class", "Debounce", "Debounce").default
local Cache = TS.import(script, script.Parent.Parent, "class", "Cache", "Cache").Cache
local function isService(query)
	local s, r = pcall(function()
		return game:GetService(query.Name) == query
	end)
	if not s then
		return false
	end
	return r
end
local _PHeCorePseudo
local getPowerHorseCorePseudo = function()
	if _PHeCorePseudo then
		return _PHeCorePseudo
	end
	local _class
	do
		local super = Pseudo
		_class = setmetatable({}, {
			__tostring = function()
				return "Anonymous"
			end,
			__index = super,
		})
		_class.__index = _class
		function _class.new(...)
			local self = setmetatable({}, _class)
			return self:constructor(...) or self
		end
		function _class:constructor()
			super.constructor(self, "Pseudo.PHe")
		end
	end
	_PHeCorePseudo = _class.new()
	return _PHeCorePseudo
end
local _predefinedPaths = {
	["@DataModel"] = game,
	["@game"] = game,
	["@Workspace"] = game:GetService("Workspace"),
	["@Players"] = game:GetService("Players"),
	["@Lighting"] = game:GetService("Lighting"),
	["@MaterialService"] = game:GetService("MaterialService"),
	["@ReplicatedFirst"] = game:GetService("ReplicatedFirst"),
	["@ReplicatedStorage"] = game:GetService("ReplicatedStorage"),
	["@ServerScriptService"] = game:GetService("ServerScriptService"),
	["@ServerStorage"] = game:GetService("ServerStorage"),
	["@StarterGui"] = game:GetService("StarterGui"),
	["@StarterPack"] = game:GetService("StarterPack"),
	["@StarterPlayer"] = game:GetService("StarterPlayer"),
	["@StarterPlayerScripts"] = game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts"),
	["@StarterCharacterScripts"] = game:GetService("StarterPlayer"):WaitForChild("StarterCharacterScripts"),
	["@Teams"] = game:GetService("Teams"),
	["@SoundService"] = game:GetService("SoundService"),
	["@Chat"] = game:GetService("Chat"),
	["@LocalizationService"] = game:GetService("LocalizationService"),
	["@LocalPlayer"] = game:GetService("Players").LocalPlayer,
	["@PlayerGui"] = if game:GetService("Players").LocalPlayer ~= nil and game:GetService("RunService"):IsRunning() == true then game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") else nil,
}
local _INTERNAL_POWERHORSE_USENODEMODULES
local PowerHorse
PowerHorse = {
	_G = getPowerHorseCorePseudo()._G,
	Pseudo = Pseudo,
	State = setmetatable({}, {
		__newindex = State,
		__index = State,
		__call = function(_, ...)
			local args = { ... }
			local s = State.new(unpack(args))
			return s, function(f)
				s:SetState(f)
				return nil
			end
		end,
	}),
	Spring = setmetatable({}, {
		__newindex = Spring,
		__index = Spring,
		__call = function(_, ...)
			local arguments_ = { ... }
			local args = arguments_
			local s = Spring.new(unpack(args))
			return s, function(f)
				s:SetGoal(f)
				return nil
			end
		end,
	}),
	Servant = Servant,
	Signal = Signal,
	SpreadOperator = SpreadOperator,
	typeIs = _typeIs,
	GetPseudoById = GetPseudoById,
	GetPseudoFromObject = GetPseudoFromObject,
	RecursiveTry = RecursiveTry,
	BatchIterate = BatchIterate,
	Color3 = color3,
	Engine = Engine,
	Compatibility = Compatibility,
	Observables = Observables,
	RuntimeDebugger = RuntimeDebugger,
	InstanceMapper = InstanceMapper,
	Debouncer = Debouncer,
	Cache = Cache,
	Promise = TS.Promise,
	ObserveInstance = function(self, Instance, Callback, Dependencies)
		local _class
		do
			local super = Pseudo
			_class = setmetatable({}, {
				__tostring = function()
					return "Anonymous"
				end,
				__index = super,
			})
			_class.__index = _class
			function _class.new(...)
				local self = setmetatable({}, _class)
				return self:constructor(...) or self
			end
			function _class:constructor()
				super.constructor(self, `PseudoInstanceObserver={Instance}`)
			end
		end
		local ObserverClass = _class.new()
		local InstanceAny = Instance
		local ObserverClassAny = ObserverClass
		ObserverClass._dev.insert(Instance.Destroying:Connect(function()
			ObserverClass:Destroy()
		end))
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(Dependency)
			local IsAttribute = (string.match(Dependency, "^#"))
			if IsAttribute ~= 0 and IsAttribute == IsAttribute and IsAttribute ~= "" and IsAttribute then
				local _dependency = Dependency
				local _arg1 = #Dependency
				local Attribute = string.sub(_dependency, 2, _arg1)
				ObserverClassAny[Attribute] = Instance:GetAttribute(Attribute)
				ObserverClass._dev.insert(Instance:GetAttributeChangedSignal(Attribute):Connect(function()
					ObserverClassAny[Dependency] = Instance:GetAttribute(Attribute)
				end))
			else
				ObserverClassAny[Dependency] = InstanceAny[Dependency]
				ObserverClass._dev.insert(Instance:GetPropertyChangedSignal(Dependency):Connect(function()
					ObserverClassAny[Dependency] = InstanceAny[Dependency]
				end))
			end
		end
		for _k, _v in Dependencies do
			_callback(_v, _k - 1, Dependencies)
		end
		-- ▲ ReadonlyArray.forEach ▲
		ObserverClass:Observe(Callback, Dependencies)
		return ObserverClass
	end,
	setNodeModules = function(self, node_modules)
		local _ = getPowerHorseCorePseudo()
		local _node_modules = node_modules
		local _exp = typeof(_node_modules) == "Instance"
		local _node_modules_1 = node_modules
		_:assert(_exp, `Instance expected, got {typeof(_node_modules_1)}`)
		_INTERNAL_POWERHORSE_USENODEMODULES = node_modules
	end,
	createClass = function(self, constructor, ...)
		local args = { ... }
		local luaprovider = self:_getluaprovider()
		getPowerHorseCorePseudo():assert(luaprovider, `rbxts-lua-provider needs to be installed.`)
		return luaprovider.class(constructor, unpack(args))
	end,
	PKG = setmetatable({}, {
		__index = function(_, k)
			return PowerHorse:require(`@mekstuff-rbxts/{k}`)
		end,
		__call = function(_, ...)
			local args = { ... }
			return PowerHorse:require(`@mekstuff-rbxts/{args[1]}`)
		end,
	}),
	_getluaprovider = function(self)
		local _result = script.Parent
		if _result ~= nil then
			_result = _result.Parent
			if _result ~= nil then
				_result = _result:FindFirstChild("lua-provider")
			end
		end
		local provider = _result:FindFirstChild("LuaProvider")
		if provider then
			return require(provider)
		end
	end,
	luaproviderRequire = function(self, module)
		local _luaprovider = self:_getluaprovider()
		return if _luaprovider then _luaprovider.require(module, _INTERNAL_POWERHORSE_USENODEMODULES) else (require(module))
	end,
	require = function(self, root, path)
		local _import = self:importAsync(root, path)
		if not (typeof(_import) == "Instance") then
			return _import
		end
		if not _import:IsA("ModuleScript") then
			local hasPackageJSON = _import:FindFirstChild("package") or _import:FindFirstChild("package.json")
			-- resolve main entry file from a package.json if require was called on the package folder
			if hasPackageJSON and hasPackageJSON:IsA("ModuleScript") then
				local readPackageJSON = require(hasPackageJSON)
				if type(readPackageJSON) == "table" then
					local main = readPackageJSON.main
					if type(main) == "string" then
						local pathsSplitted = string.split(main, "/")
						-- ▼ ReadonlyArray.mapFiltered ▼
						local _newValue = {}
						local _callback = function(entry)
							if entry == "init" or entry == "init.lua" or entry == "init.luau" or entry == "index" or entry == "index.lua" or entry == "index.luau" then
								return nil
							end
							return (string.gsub((string.gsub(entry, "%.luau", "")), "%.lua", ""))
						end
						local _length = 0
						for _k, _v in pathsSplitted do
							local _result = _callback(_v, _k - 1, pathsSplitted)
							if _result ~= nil then
								_length += 1
								_newValue[_length] = _result
							end
						end
						-- ▲ ReadonlyArray.mapFiltered ▲
						local mainEntryFileRelPath = table.concat(_newValue, "/")
						return PowerHorse:require(_import, mainEntryFileRelPath)
					end
				end
			end
		end
		return self:luaproviderRequire(_import)
	end,
	importAsync = function(self, root, path)
		return self:import(root, path):expect()
	end,
	import = function(self, root, path)
		local node_modules = _INTERNAL_POWERHORSE_USENODEMODULES
		local resolveNodeModules = function()
			if node_modules then
				return node_modules
			end
			local res = _predefinedPaths["@ReplicatedStorage"]:FindFirstChild("node_modules", true) or _predefinedPaths["@ServerStorage"]:FindFirstChild("node_modules", true) or _predefinedPaths["@ReplicatedStorage"]:WaitForChild("node_modules", 40)
			if not res then
				getPowerHorseCorePseudo():assert(`Could not resolve node modules.`)
			end
			return res
		end
		local resolveRoot
		resolveRoot = function(directory)
			local parent = directory.Parent
			if directory == game then
				return directory
			end
			if not parent then
				return directory
			end
			if parent == game and isService(directory) then
				return directory
			end
			return resolveRoot(parent)
		end
		local resolvePath = function(path)
			return TS.Promise.new(function(resolve, reject)
				local splits = string.split(path, "/")
				local _root = root
				local lastParent = if typeof(_root) == "Instance" then root else script
				local getItem = function(split)
					if _predefinedPaths[split] then
						return _predefinedPaths[split]
					end
					local _value = (string.match(split, "^@"))
					if _value ~= 0 and _value == _value and _value ~= "" and _value then
						return resolveNodeModules():WaitForChild(split)
					end
					if split == "*" then
						return resolveRoot(lastParent)
					end
					if split == "." then
						return getfenv(0).script or script
					end
					if split == ".." then
						local t = lastParent.Parent
						if t == nil then
							error(`Path invalid! Parent of "{lastParent:GetFullName()}" is nil.`)
						end
						return lastParent.Parent
					end
					local _lastParent = lastParent
					if not (typeof(_lastParent) == "Instance") then
						return lastParent[split]
					end
					local f = lastParent:FindFirstChild(split)
					if f then
						return f
					end
					local _lastParent_1 = lastParent
					local _condition = typeof(_lastParent_1) == "Instance"
					if _condition then
						_condition = lastParent:IsA("ModuleScript")
					end
					if _condition then
						local req = self:luaproviderRequire(lastParent)
						local _value_1 = req[split]
						if _value_1 ~= 0 and _value_1 == _value_1 and _value_1 ~= "" and _value_1 then
							return req[split]
						end
					end
					return lastParent:WaitForChild(split)
				end
				local index = 0
				TS.try(function()
					do
						index = 0
						local _shouldIncrement = false
						while true do
							if _shouldIncrement then
								index += 1
							else
								_shouldIncrement = true
							end
							if not (index < #splits) then
								break
							end
							local split = splits[index + 1]
							if split == "" then
								continue
							end
							local _condition = (string.match(split, "%*$"))
							if _condition ~= 0 and _condition == _condition and _condition ~= "" and _condition then
								_condition = #split > 1
							end
							local isRequireCall = _condition
							local _result
							if isRequireCall ~= 0 and isRequireCall == isRequireCall and isRequireCall ~= "" and isRequireCall then
								local _arg1 = #split - 1
								_result = string.sub(split, 0, _arg1)
							else
								_result = split
							end
							local res = getItem(_result)
							if isRequireCall ~= 0 and isRequireCall == isRequireCall and isRequireCall ~= "" and isRequireCall then
								if not res:IsA("ModuleScript") then
									error(`Target must be a ModuleScript* to require using "*"! "{split}"`)
								end
							else
								lastParent = res
							end
						end
					end
					resolve(lastParent)
				end, function(err)
					reject(`Import failed on query index "{index}"/"{splits[index + 1]}" for "{path}". ERROR: {err}`)
				end)
			end)
		end
		return TS.Promise.try(function()
			local _root = root
			return resolvePath(if typeof(_root) == "Instance" then path else root):expect()
		end)
	end,
	error = function(err, level)
		return getPowerHorseCorePseudo():error(err, level)
	end,
	warn = function(...)
		local args = { ... }
		return getPowerHorseCorePseudo():warn(unpack(args))
	end,
	log = function(...)
		local args = { ... }
		return getPowerHorseCorePseudo():log(unpack(args))
	end,
}
return {
	PowerHorse = PowerHorse,
}
