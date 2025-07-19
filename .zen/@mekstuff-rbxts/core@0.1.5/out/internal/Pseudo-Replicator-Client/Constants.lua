local ProxyModule = script.Parent:WaitForChild("ReplicatorScriptPointer").Value
local ReplicatorScriptRemote = ProxyModule:WaitForChild("ReplicatorScriptRemote") :: RemoteEvent
local ReplicatorTransmitterRemote = ProxyModule:WaitForChild("ReplicatorTransmitterRemote") :: RemoteEvent
local node_modules = ProxyModule.Parent.Parent.Parent.Parent.Parent
	or ProxyModule.Parent.Parent.Parent:FindFirstChild("node_modules") -- or statement is to support core while in dev mode.

local orginization = node_modules:WaitForChild("@mekstuff-rbxts")
local core = orginization:FindFirstChild("core") or orginization:FindFirstChild("core-lua")
local PseudoModule = core:WaitForChild("out")

local manifest = require(PseudoModule:WaitForChild("package.manifest"))

local LuaProvider = require(PseudoModule:WaitForChild("lua-provider"):WaitForChild("LuaProvider"))

local constants = {
	ProxyModule = ProxyModule,
	node_modules = node_modules,
	PseudoModule = PseudoModule,

	ReplicatorScriptRemote = ReplicatorScriptRemote,
	ReplicatorTransmitterRemote = ReplicatorTransmitterRemote,

	PowerHorse = LuaProvider.require(PseudoModule, node_modules).PowerHorse,

	manifest = manifest,

	--> lua-provider
	LuaProvider = LuaProvider,
}

return constants
