-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    15/09/2025 21:53:17
	
]]
local PseudoCollector = TS.import(script, script.Parent, "GetPseudoById").PseudoCollector
local _typeIs = TS.import(script, script.Parent, "typeIs")._typeIs
--[[
	*
	 *
	 * Gets the PseudoId from a unique pointer string ref.
	 *
	 * @param PointerStringRef
	 
]]
local function GetPseudoIdFromPointerStringRef(PointerStringRef)
	local PseudoId = (string.match(PointerStringRef, "__Pseudo%.PointerStringRef=%((.*)%)"))
	return tostring(PseudoId)
end
--[[
	*
	 *
	 * Gets a Pseudo from a unique pointer string ref.
	 *
	 * @param PointerStringRef
	 
]]
local function GetPseudoFromPointerStringRef(PointerStringRef)
	local PseudoId = GetPseudoIdFromPointerStringRef(PointerStringRef)
	if PseudoId == nil then
		return nil
	end
	return PseudoCollector[PseudoId]
end
--[[
	*
	 *
	 * String points to a Pseudo
	 *
	 * @param PointerStringRef
	 
]]
local function CreatePseudoPointerStringRef(Pseudo)
	if true == true then
		return nil
	end
	if _typeIs(Pseudo, "Pseudo") ~= true then
		return nil
	end
	return `__Pseudo.PointerStringRef=({Pseudo:GetIdAsync()})`
end
return {
	GetPseudoIdFromPointerStringRef = GetPseudoIdFromPointerStringRef,
	GetPseudoFromPointerStringRef = GetPseudoFromPointerStringRef,
	CreatePseudoPointerStringRef = CreatePseudoPointerStringRef,
}
