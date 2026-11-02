-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
		Typed with ❤️ @mekstuff
		ea940b38-e559-40cf-96a0-224596dc4433::603431:dd48c4
	
		PowerHorse Engine Core
	
]]
-- eslint-disable roblox-ts/no-private-identifier 
-- import Syncer from "./class/Replication/Syncer";
local Debouncer = TS.import(script, script, "class", "Debounce", "Debounce").default
local RecursiveTry = TS.import(script, script, "internal", "functions", "RecursiveTry").default
local BatchIterate = TS.import(script, script, "internal", "functions", "BatchIterate").default
local _Servant = TS.import(script, script, "class", "Servant", "Servant")
local Servant = _Servant.Servant
local ServantPromise = _Servant.ServantPromise
local Pseudo = TS.import(script, script, "class", "Pseudo", "Pseudo").Pseudo
local _typeIs = TS.import(script, script, "internal", "functions", "typeIs")._typeIs
-- import { threader, isThreader } from "@mekstuff-rbxts/threader";
local Engine = TS.import(script, script, "class", "Engine", "Engine").Engine
local GetPseudoById = TS.import(script, script, "internal", "functions", "GetPseudoById").GetPseudoById
local PseudoClientReplicator = TS.import(script, script, "class", "Replication", "PseudoClientReplicator").PseudoClientReplicator
local State = TS.import(script, script, "class", "State", "State").State
local Signal = TS.import(script, script, "class", "Signal", "Signal").Signal
local Compatibility = TS.import(script, script, "class", "Compatibility", "Compatibility").Compatibility
local Observables = TS.import(script, script, "class", "Observables", "Observables").Observables
local InstanceMapper = TS.import(script, script, "class", "InstanceMapper", "InstanceMapper").InstanceMapper
local Spring = TS.import(script, script, "class", "Spring", "Spring").Spring
local Cache = TS.import(script, script, "class", "Cache", "Cache").Cache
local Queue = TS.import(script, script, "class", "Queue", "Queue").default
local GetPseudoFromObject = TS.import(script, script, "internal", "functions", "GetPseudoByObject").GetPseudoFromObject
local tryUseEffectCleanup = TS.import(script, script, "internal", "functions", "CalluseEffectServant").tryUseEffectCleanup
local Effect = TS.import(script, script, "internal", "functions", "Effect", "Effect").Effect
local RuntimeDebugger = TS.import(script, script, "class", "RuntimeDebugger", "RuntimeDebugger").default
local PowerHorse = TS.import(script, script, "internal", "PowerHorse").PowerHorse
return {
	Signal = Signal,
	Pseudo = Pseudo,
	Servant = Servant,
	PseudoClientReplicator = PseudoClientReplicator,
	State = State,
	Spring = Spring,
	Queue = Queue,
	Cache = Cache,
	RuntimeDebugger = RuntimeDebugger,
	PowerHorse = PowerHorse,
	Compatibility = Compatibility,
	Observables = Observables,
	InstanceMapper = InstanceMapper,
	Debouncer = Debouncer,
	Engine = Engine,
	Effect = Effect,
	ServantPromise = ServantPromise,
	typeIs = _typeIs,
	GetPseudoById = GetPseudoById,
	GetPseudoFromObject = GetPseudoFromObject,
	tryUseEffectCleanup = tryUseEffectCleanup,
	RecursiveTry = RecursiveTry,
	BatchIterate = BatchIterate,
}
