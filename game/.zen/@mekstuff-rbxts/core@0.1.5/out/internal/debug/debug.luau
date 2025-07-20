-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local exports = {}
exports.assertp = TS.import(script, script.Parent, "assert").assertp
exports.errorp = TS.import(script, script.Parent, "error").errorp
exports.logp = TS.import(script, script.Parent, "log").logp
exports.warnp = TS.import(script, script.Parent, "warn").warnp
return exports
