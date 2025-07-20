-- Compiled with roblox-ts v2.3.0
local TS = _G[script]
local exports = {}
-- servant is now apart of `mekstuff-rbxts/core`.
local _core = TS.import(script, TS.getModule(script, "@mekstuff-rbxts", "core").out)
exports.sp = _core.ServantPromise
exports.ServantPromise = _core.ServantPromise
exports.Servant = _core.Servant
return exports
