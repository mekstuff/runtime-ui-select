-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
	    Typed with ❤️ @mekstuff
	    04/10/2024 14:59:59
	    a50b378b-5573-4826-9389-60b689253cc5::149122:41c515
	
]]
local Pseudo = TS.import(script, script.Parent.Parent, "Pseudo", "Pseudo").Pseudo
local State = TS.import(script, script.Parent.Parent, "State", "State").State
local ObservablesClass
do
	local super = Pseudo
	ObservablesClass = setmetatable({}, {
		__tostring = function()
			return "ObservablesClass"
		end,
		__index = super,
	})
	ObservablesClass.__index = ObservablesClass
	function ObservablesClass.new(...)
		local self = setmetatable({}, ObservablesClass)
		return self:constructor(...) or self
	end
	function ObservablesClass:constructor()
		super.constructor(self, "Observables")
	end
	function ObservablesClass:ObserveCharacter(Player, Callback)
		local CharacterState = State.new(Player.Character or (Player.CharacterAdded:Wait()))
		CharacterState._dev.insert(Player.CharacterAdded:Connect(function(Character)
			CharacterState:SetState(Character)
		end))
		if Callback then
			CharacterState:Observe(function()
				return Callback(CharacterState.State)
			end, { "State" })
		end
		return CharacterState
	end
	function ObservablesClass:ObserveHumanoid(Player, Callback)
		local HumanoidState = State.new((Player.Character or (Player.CharacterAdded:Wait())):WaitForChild("Humanoid"))
		HumanoidState._dev.insert(self:ObserveCharacter(Player, function(Character)
			task.spawn(function()
				HumanoidState:SetState(Character:WaitForChild("Humanoid"))
			end)
		end))
		if Callback then
			HumanoidState:Observe(function()
				return Callback(HumanoidState.State)
			end, { "State" })
		end
		return HumanoidState
	end
	function ObservablesClass:ObserveHumanoidRootPart(Player, Callback)
		local HumanoidRootPartState = State.new((Player.Character or (Player.CharacterAdded:Wait())):WaitForChild("HumanoidRootPart"))
		HumanoidRootPartState._dev.insert(self:ObserveCharacter(Player, function(Character)
			task.spawn(function()
				HumanoidRootPartState:SetState(Character:WaitForChild("HumanoidRootPart"))
			end)
		end))
		if Callback then
			HumanoidRootPartState:Observe(function()
				return Callback(HumanoidRootPartState.State)
			end, { "State" })
		end
		return HumanoidRootPartState
	end
end
local Observables = ObservablesClass.new()
local default = Observables
return {
	ObservablesClass = ObservablesClass,
	Observables = Observables,
	default = default,
}
