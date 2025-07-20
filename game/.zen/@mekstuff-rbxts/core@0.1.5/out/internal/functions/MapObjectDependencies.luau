-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local Shared = TS.import(script, script.Parent.Parent, "shared", "Shared").Shared
--[[
	*
	 * Mapping values
	 
]]
local function MapObjectDependencies(object, props, dependencies, concealwarns)
	-- ▼ ReadonlyArray.forEach ▼
	local _callback = function(dep)
		for _, prop in props do
			local strsplit = string.split(prop, Shared.DEPS_STRING_ID_SEPERATOR)
			local MyPropertyName
			local DepPropertyName
			if strsplit[2] ~= nil then
				MyPropertyName = strsplit[1]
				DepPropertyName = strsplit[2]
			else
				MyPropertyName = prop
				DepPropertyName = prop
			end
			local s, r = pcall(function()
				local tdep = dep
				-- const tprop = prop as string;
				local tthis = object
				--this checks to make sure that the property is valid existing members of the dep.
				local _ = tdep[DepPropertyName]
				--this will assign the value but will trigger an __index on pseudo to make sure prop is a valid existing member of this.
				tdep[DepPropertyName] = tthis[MyPropertyName]
			end)
			if s == false then
				if not concealwarns then
					warn(`Failed to map property '{tostring(prop)}' to dependency {tostring(dep)} from Pseudo {tostring(object)}.\n\n{r}`)
				end
			end
		end
	end
	for _k, _v in dependencies do
		_callback(_v, _k - 1, dependencies)
	end
	-- ▲ ReadonlyArray.forEach ▲
end
return {
	MapObjectDependencies = MapObjectDependencies,
}
