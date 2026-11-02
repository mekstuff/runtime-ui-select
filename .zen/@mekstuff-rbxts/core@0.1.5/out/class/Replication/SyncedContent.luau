-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
local Engine = TS.import(script, script.Parent.Parent, "Engine", "Engine").Engine
local Pseudo = TS.import(script, script.Parent.Parent, "Pseudo", "Pseudo").Pseudo
local SyncedContent
do
	local super = Pseudo
	SyncedContent = setmetatable({}, {
		__tostring = function()
			return "SyncedContent"
		end,
		__index = super,
	})
	SyncedContent.__index = SyncedContent
	function SyncedContent.new(...)
		local self = setmetatable({}, SyncedContent)
		return self:constructor(...) or self
	end
	function SyncedContent:constructor(SyncId, _Syncer, _initialValueNoServerCheck)
		super.constructor(self, "SyncedContent")
		self._Syncer = _Syncer
		self.Initialized = false
		self.Value = nil
		local ServerCoreSyncerRemote = Engine.FetchReplicatedStorage():WaitForChild(`CoreSync-{self._Syncer.ClassName}`)
		self.Name = SyncId
		self._dev.set("_internal_syncerOCE", ServerCoreSyncerRemote.OnClientEvent:Connect(function(Arg0, ServerSentSyncId, content)
			if ServerSentSyncId ~= SyncId then
				return nil
			end
			if Arg0 == "$initialize" then
				self.Value = content
				self:useAssignReadonlyProperty("Initialized", true)
				return nil
			end
			if Arg0 == "$update" then
				if not self.Initialized then
					return nil
				end
				self.Value = content
				return nil
			end
		end))
		if _initialValueNoServerCheck ~= nil then
			self.Value = _initialValueNoServerCheck
			self:useAssignReadonlyProperty("Initialized", true)
		else
			ServerCoreSyncerRemote:FireServer("$initialize", SyncId)
		end
	end
	function SyncedContent:Sync()
		(Engine.FetchReplicatedStorage():WaitForChild(`CoreSync-{self._Syncer.ClassName}`)):FireServer()
	end
	function SyncedContent:useValue(Callback)
		return self:Observe(function()
			Callback(self.Value)
		end, { "Value" })
	end
end
return {
	SyncedContent = SyncedContent,
}
