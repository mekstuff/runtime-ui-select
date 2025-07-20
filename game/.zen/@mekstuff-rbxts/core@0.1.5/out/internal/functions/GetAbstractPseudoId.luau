-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local GenerateRandomString = TS.import(script, script.Parent, "GenerateRandomString").GenerateRandomString
--*
local function GetAbstractPseudoId(ClassName)
	return ClassName .. GenerateRandomString(nil)
end
return {
	GetAbstractPseudoId = GetAbstractPseudoId,
}
