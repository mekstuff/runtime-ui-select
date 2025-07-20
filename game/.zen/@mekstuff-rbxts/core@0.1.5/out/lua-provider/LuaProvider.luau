--[=[
    Made with ❤️ by @mekstuff
    Licensed under the MIT License. © Mekstuff
    -------------------------------------
    files in the include/ directory are licensed under the MIT License. © roblox-ts
    -------------------------------------
    A simple module that bridges the use of roblox-ts compiled packages in a non roblox-ts game
]=]
local LuaProvider = {}

local include = script.Parent:FindFirstChild("runtime-port")

if not include then
	error(
		`Could not resolve "include". make sure both @mekstuff-rbxts/core and @mekstuff-rbxts/core-lua is installed as you seem to be trying to use the LuaProvider.`
	)
end

local RuntimeLib = require(include:WaitForChild("RuntimeLib"))
LuaProvider.Promise = require(include:WaitForChild("Promise"))
LuaProvider.RuntimeLib = RuntimeLib
--[=[
    ```lua
    LuaProvider.import("../../path")
    LuaProvider.import("@ReplicatedStorage/path")
    LuaProvider.import(".") --> Outputs DataModel
    LuaProvider.import("..") --> Outputs script.Parent
    LuaProvider.import("@ReplicatedStorage/..") --> Outputs DataModel (ReplicatedStorage.Parent)
    ```
]=]
LuaProvider.import = function(path: { string } | string)
	local imports = {}
	if typeof(path) == "string" then
		imports = path:split("/")
	else
		imports = path
	end
	local lastParent: Instance = script
	for _, v in imports do
		local serviceImport = v:match("^@(.+)")
		if serviceImport then
			lastParent = game:GetService(serviceImport)
			continue
		end
		if v == "" then
			continue
		end
		if v == "." then
			lastParent = game
			continue
		end
		if v == ".." then
			lastParent = lastParent.Parent
			continue
		end
		local findFirst = lastParent:FindFirstChild(v)
		if not findFirst then
			findFirst = lastParent:WaitForChild(v)
		end
		lastParent = findFirst
	end
	return lastParent
end

--[=[
    ```lua
    local require = LuaProvider.require
    require(...) -- this will require as normal but any package within ReplicatedStorage/node_modules will have their environment set to _G.
    ```
]=]
LuaProvider.require = function(
	module: ModuleScript | { string },
	node_modules: Folder?
)
	if not node_modules then
		node_modules = if script.Parent
				and script.Parent.Parent
				and script.Parent.Parent.Parent
				and script.Parent.Parent.Parent.Parent
				and script.Parent.Parent.Parent.Parent.Parent
				and script.Parent.Parent.Parent.Parent.Parent.Name == "node_modules"
			then script.Parent.Parent.Parent.Parent.Parent
			else nil
	end
	if typeof(module) == "table" then
		node_modules = node_modules or game:GetService("ReplicatedStorage"):WaitForChild("node_modules", 200)
		local function r(i: string, p: Instance)
			local s = module[i]
			local f = p:FindFirstChild(s)
			if not f then
				error(`Failed to find "{s}" within "{p}"`)
			end
			if i == #module then
				return f
			end
			return r(i + 1, f)
		end
		module = r(1, node_modules)
	end

	node_modules = node_modules or game:GetService("ReplicatedStorage"):WaitForChild("node_modules", 200)
	if not node_modules then
		error("Could not resolve node_modules.")
	end

	_G[module] = RuntimeLib --> set env
	local value = require(module)

	_G[module] = nil
	return value
end

--[=[
    "Compiles" a roblox-ts metatable class.

    @param constructor Will be called whenever the class is created, the first argument will be the class and the
    following arguments will be the constructor arguments.

    @param extends Inherit another class.

    Any extra arguments after the `extends` argument will be passed to the super constructor of the extended class.
]=]
LuaProvider.class = function(constructor: (self: any, ...any) -> any, extends: table?, ...: any)
	local superargs = { ... }
	local newClass = setmetatable({}, {
		__tostring = function()
			return "LuaProviderClass"
		end,
		__index = extends,
	})
	newClass.__index = newClass
	function newClass.new(...)
		local self = setmetatable({}, newClass)
		return self:constructor(...) or self
	end
	function newClass:constructor(...)
		if extends then
			extends.constructor(self, unpack(superargs))
		end
		constructor(self, ...)
	end
	return newClass
end

--[[
	Similar to LuaProvider.class but allows you to have a function run before extends.constructor and constructor AKA "setup"
]]
LuaProvider.customClass = function(
	setup: (self: any, ...any) -> any,
	constructor: (self: any, ...any) -> any,
	extends: table?,
	...: any
)
	local superargs = { ... }
	local newClass = setmetatable({}, {
		__tostring = function()
			return "LuaProviderCustomClass"
		end,
		__index = extends,
	})
	newClass.__index = newClass
	function newClass.new(...)
		local self = setmetatable({}, newClass)
		return self:constructor(...) or self
	end
	function newClass:constructor(...)
		setup(self, ...)
		if extends then
			extends.constructor(self, unpack(superargs))
		end
		constructor(self, ...)
	end
	return newClass
end

return LuaProvider
