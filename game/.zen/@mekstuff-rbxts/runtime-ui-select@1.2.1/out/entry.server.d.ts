export {};
/**
 * Basic Free Command Line Version:
--[[
    Simple version of Rutus, Execute in command line then click on any GUI elements on screen
    to select it within the explorer!
    
    Get Rutus: https://devforum.roblox.com/
]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SelectionService = game:GetService("Selection")
local UserInputService = game:GetService("UserInputService")

local IsClient = RunService:IsClient()
local IsRunning = RunService:IsRunning()

if(IsClient == false)then
    warn("Rutus CMDL - Command should only be executed on the client.")
    return
end

if(IsRunning == false)then
    warn("Rutus CMDL - Command should only be executed while the experience is running.")
    return
end

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui") :: PlayerGui
    
local ActiveRuntimeUISelectConnection: RBXScriptConnection

local function DisableRuntimeUISelect()
    if(ActiveRuntimeUISelectConnection)then
        ActiveRuntimeUISelectConnection:Disconnect()
        ActiveRuntimeUISelectConnection = nil
    end
end

local function EnableRuntimeUISelect()
    DisableRuntimeUISelect()
    print("Rutus CMDL - Listening for GUI Selection...")
    ActiveRuntimeUISelectConnection = UserInputService.InputBegan:Connect(function(Input)
        if(Input.UserInputType ~= Enum.UserInputType.MouseButton1)then
            return
        end
        DisableRuntimeUISelect()
        local GuiElementsAtPosition = PlayerGui:GetGuiObjectsAtPosition(Input.Position.X, Input.Position.Y)
        local TargetElement = GuiElementsAtPosition[1]
        if(TargetElement == nil)then
            print("Rutus CMDL - There were no visible GUI's where you pressed!")
            return
        end
        print(`Rutus CMDL - Selected {TargetElement}. Other Elements:`)
        for index, element in GuiElementsAtPosition do
            if(index == 1)then
                continue
            end
            print("\t", element)
        end
    end)
end

EnableRuntimeUISelect()
 */
