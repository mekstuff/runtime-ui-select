-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    20/05/2025 13:01:37
	
]]
local Pseudo = TS.import(script, script.Parent.Parent, "Pseudo", "Pseudo").Pseudo
local Cache
do
	local super = Pseudo
	Cache = setmetatable({}, {
		__tostring = function()
			return "Cache"
		end,
		__index = super,
	})
	Cache.__index = Cache
	function Cache.new(...)
		local self = setmetatable({}, Cache)
		return self:constructor(...) or self
	end
	function Cache:constructor(FetchFunction)
		super.constructor(self, "Cache")
		self.FetchFunction = FetchFunction
		self._cached = {}
		self.AutoClearExpiredCacheInterval = -1
		self.CacheLifetime = 10
		self:Observe(function()
			if self.AutoClearExpiredCacheInterval == -1 then
				return nil
			end
			local IsActive = true
			local Interval = self.AutoClearExpiredCacheInterval
			local RunDelay
			RunDelay = function()
				if IsActive == false then
					return nil
				end
				task.delay(Interval, function()
					if IsActive == false then
						return nil
					end
					self:ClearExpired()
					RunDelay()
				end)
			end
			RunDelay()
			return function()
				IsActive = false
			end
		end, { "AutoClearExpiredCacheInterval" })
	end
	function Cache:GetKeyID(...)
		local args = { ... }
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#args)
		local _callback = function(x)
			return tostring(x)
		end
		for _k, _v in args do
			_newValue[_k] = _callback(_v, _k - 1, args)
		end
		-- ▲ ReadonlyArray.map ▲
		return table.concat(_newValue, "--")
	end
	function Cache:_getIsCachedDataExpired(CachedData)
		local diff = tick() - CachedData.time
		local _condition = CachedData.lifetime
		if _condition == nil then
			_condition = self.CacheLifetime
		end
		if diff > _condition then
			return true
		end
		return false
	end
	function Cache:GetCached(KeyId)
		local __cached = self._cached
		local _keyId = KeyId
		local CachedData = __cached[_keyId]
		if CachedData == nil then
			return nil
		end
		if self:_getIsCachedDataExpired(CachedData) == true then
			self:Delete(KeyId)
			return nil
		end
		return CachedData.value
	end
	function Cache:Get(...)
		local args = { ... }
		local Key = self:GetKeyID(unpack(args))
		local IsCached = self:GetCached(Key)
		if IsCached ~= 0 and IsCached == IsCached and IsCached ~= "" and IsCached then
			return IsCached
		end
		local Results = self.FetchFunction(unpack(args))
		self:Set(Key, Results)
		return Results
	end
	function Cache:Set(KeyId, Value, Lifetime)
		local __cached = self._cached
		local _keyId = KeyId
		local _arg1 = {
			time = tick(),
			value = Value,
			lifetime = Lifetime,
		}
		__cached[_keyId] = _arg1
	end
	function Cache:Delete(KeyId)
		local __cached = self._cached
		local _keyId = KeyId
		-- ▼ Map.delete ▼
		local _valueExisted = __cached[_keyId] ~= nil
		__cached[_keyId] = nil
		-- ▲ Map.delete ▲
		return _valueExisted
	end
	function Cache:Clear()
		table.clear(self._cached)
		return nil
	end
	function Cache:ClearExpired()
		local _exp = self._cached
		-- ▼ ReadonlyMap.forEach ▼
		local _callback = function(Entry, KeyId)
			if self:_getIsCachedDataExpired(Entry) == false then
				return nil
			end
			local __cached = self._cached
			local _keyId = KeyId
			__cached[_keyId] = nil
		end
		for _k, _v in _exp do
			_callback(_v, _k, _exp)
		end
		-- ▲ ReadonlyMap.forEach ▲
	end
end
return {
	Cache = Cache,
}
