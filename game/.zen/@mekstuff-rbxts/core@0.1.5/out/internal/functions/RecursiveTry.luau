-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    05/09/2024 08:38:05
	    840b2a89-cbdf-4f92-9536-91d620e55f4f::500872:50e4e4
	
]]
-- function RecursiveTry<T>(
-- 	Callback: (resolve: Callback, reject: Callback) => T,
-- 	MaximumAttempts?: number,
-- 	IncrementalYields?: number,
-- 	AutoResolveThread?: boolean,
-- ): LuaTuple<[false, string]>;
-- function RecursiveTry<T>(
-- 	Callback: (resolve: Callback, reject: Callback) => T,
-- 	MaximumAttempts?: number,
-- 	IncrementalYields?: number,
-- 	AutoResolveThread?: boolean,
-- ): LuaTuple<[true, T]>;
--[[
	*
	 *
	 * @param Callback The callback that will be ran, Provides resolve and reject functions for manually resolving and rejecting.
	 * @param MaximumAttempts Maximum attempts before cancelling recursion. Defaults to `5`.
	 * @param IncrementalYields Incremental yield on each try. Defaults to `0.5`.
	 * @param AutoResolveThread If the Callback runs without any errors, it will resolve with the value it returned. Defaults to `true`.
	 * @returns
	 
]]
local function RecursiveTry(Callback, MaximumAttempts, IncrementalYields, AutoResolveThread)
	if MaximumAttempts == nil then
		MaximumAttempts = 5
	end
	if IncrementalYields == nil then
		IncrementalYields = 0.5
	end
	if AutoResolveThread == nil then
		AutoResolveThread = true
	end
	local _tryIndex = 1
	local _errors = {}
	local _try
	_try = function()
		local _promise
		_promise = TS.Promise.new(function(resolve, reject)
			local res = Callback(resolve, reject)
			if not AutoResolveThread then
				return nil
			end
			task.defer(function()
				if _promise:getStatus() == "Started" then
					return resolve(res)
				end
			end)
		end)
		local s, r = _promise:await()
		if not s then
			local __errors = _errors
			local _arg0 = tostring(r)
			table.insert(__errors, _arg0)
			if _tryIndex >= MaximumAttempts then
				-- ▼ ReadonlyArray.map ▼
				local _newValue = table.create(#_errors)
				local _callback = function(err, index)
					return `Attempt [{index + 1}/{MaximumAttempts}] = {err}`
				end
				for _k, _v in _errors do
					_newValue[_k] = _callback(_v, _k - 1, _errors)
				end
				-- ▲ ReadonlyArray.map ▲
				local err = `Recursive Try failed, Error traceback:\n{table.concat(_newValue, "\n")}`
				-- warn(err);
				return false, tostring(err)
			end
			task.wait(IncrementalYields + _tryIndex)
			_tryIndex += 1
			return _try()
		end
		return true, r
	end
	return _try()
end
local default = RecursiveTry
return {
	RecursiveTry = RecursiveTry,
	default = default,
}
