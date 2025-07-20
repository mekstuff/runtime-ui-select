-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    18/12/2024 18:46:02
	
]]
local warnp = TS.import(script, script.Parent.Parent, "debug", "warn").warnp
local _typeIs = TS.import(script, script.Parent, "typeIs")._typeIs
--[[
	*
	 * Tries to get the pseudo id from the object
	 
]]
local function ThrowInternalDestroyWarn(Reason, Err)
	warnp(`Internal Destroy Error ({Reason}) -> {Err}`)
end
--[[
	*
	 * Cleans up object
	 
]]
local function DestroyOnObject(f, maxTraverseDepth, warnName, totalTraverseDepth)
	if totalTraverseDepth == nil then
		totalTraverseDepth = 0
	end
	local pcallwrap = function(func, reason)
		local s, r = pcall(function()
			return func()
		end)
		if s == false then
			ThrowInternalDestroyWarn(if reason ~= nil then reason else "_destroyOnObject Failed.", r)
		end
		return s, r
	end
	local _f = f
	if type(_f) == "table" then
		local s, r = pcallwrap(function()
			local destroyMethod = if f.Destroy ~= nil then "Destroy" elseif f.destroy ~= nil then "destroy" elseif f.Disconnect ~= nil then "Disconnect" elseif f.disconnect ~= nil then "disconnect " else nil
			if destroyMethod ~= nil then
				f[destroyMethod](f)
				return true
			end
		end)
		if s and r == true then
			return nil
		end
	end
	for k, v in pairs(f) do
		local _value = type(v) == "function" and type(k) == "string" and (string.match(k, "^_internal_pseudo_cleanup_method"))
		if _value ~= 0 and _value == _value and _value ~= "" and _value then
			coroutine.wrap(function()
				v()
			end)()
			continue
		end
		if type(v) ~= "userdata" and not (type(v) == "table") then
			continue
		end
		if typeof(v) == "RBXScriptConnection" then
			if v.Connected then
				v:Disconnect()
			end
		elseif _typeIs(v, "threader") then
			v:tryClose()
		elseif type(v) == "thread" then
			pcallwrap(function()
				coroutine.close(v)
			end)
		elseif typeof(v) == "Instance" then
			pcallwrap(function()
				v:Destroy()
			end)
		elseif _typeIs(v, "Pseudo") then
			pcallwrap(function()
				v:Destroy()
			end)
		elseif TS.Promise.is(v) then
			pcallwrap(function()
				v:cancel()
			end)
		elseif type(v) == "table" then
			if totalTraverseDepth < maxTraverseDepth then
				DestroyOnObject(v, maxTraverseDepth, warnName, totalTraverseDepth + 1)
			else
				warnp(`{warnName} exceeded its _dev traverse depth of [{maxTraverseDepth}] with array of key "{k}".`)
			end
		end
		if k ~= "___ue" and k ~= "_internal_usePropertyEffectsQueryMaps" then
			-- "._dev.___ue" is used to store useEffect servants callback and cleanup functions, we do not remove it here.
			-- "_internal_usePropertyEffectsQueryMaps" is used to store references of use effects mapped to properties..
			f[k] = nil
		end
	end
end
return {
	DestroyOnObject = DestroyOnObject,
}
