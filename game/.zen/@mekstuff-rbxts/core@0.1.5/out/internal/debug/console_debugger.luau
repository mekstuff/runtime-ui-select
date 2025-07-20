-- Compiled with roblox-ts v3.0.0
--[[
	
	    Typed with ❤️ @mekstuff
	    14/03/2025 00:37:39
	
]]
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local function ConsoleLogPowerHorseEngineRunning()
	if true == true then
		return nil
	end
	local _PackagesContainer = script.Parent
	if _PackagesContainer ~= nil then
		_PackagesContainer = _PackagesContainer.Parent
		if _PackagesContainer ~= nil then
			_PackagesContainer = _PackagesContainer.Parent
			if _PackagesContainer ~= nil then
				_PackagesContainer = _PackagesContainer.Parent
				if _PackagesContainer ~= nil then
					_PackagesContainer = _PackagesContainer.Parent
				end
			end
		end
	end
	local PackagesContainer = _PackagesContainer
	if PackagesContainer == nil then
		print(`Running PowerHorseEngine On The Server (Unknown Location)\n`)
		return nil
	end
	local Realm = if RunService:IsClient() then "Client" else "Server"
	local ClientName = if RunService:IsClient() then (if Players.LocalPlayer then Players.LocalPlayer.Name else `UNKNOWN`) else `REMOTE`
	local _exp = PackagesContainer:GetChildren()
	-- ▼ ReadonlyArray.map ▼
	local _newValue = table.create(#_exp)
	local _callback = function(PackageFolder)
		return PackageFolder.Name
	end
	for _k, _v in _exp do
		_newValue[_k] = _callback(_v, _k - 1, _exp)
	end
	-- ▲ ReadonlyArray.map ▲
	table.sort(_newValue, function(a, b)
		return a < b
	end)
	local PackagesName = _newValue
	local _exp_1 = #PackagesName
	local _exp_2 = PackagesContainer.Name
	local _arg0 = `\n\t- {PackagesContainer.Name}/`
	-- ▼ ReadonlyArray.join ▼
	local _arg0_1 = _arg0
	if _arg0_1 == nil then
		_arg0_1 = ", "
	end
	-- ▲ ReadonlyArray.join ▲
	print(`\n\nUsing PowerHorseEngine On {Realm} ({ClientName})\n{_exp_1} PHe Packages Installed:\n\t- {_exp_2}/{table.concat(PackagesName, _arg0_1)}\n`)
end
return {
	ConsoleLogPowerHorseEngineRunning = ConsoleLogPowerHorseEngineRunning,
}
