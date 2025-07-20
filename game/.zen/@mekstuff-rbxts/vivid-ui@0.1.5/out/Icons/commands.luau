-- Compiled with roblox-ts v3.0.0
--[[
	
	    Typed with ❤️ @mekstuff
	    01/06/2025 12:59:07
	
]]
--[=[
	
	--[[
		Typed with ❤️ @mekstuff
		01/06/2025 12:39:46
		
		Use this command to extract icons from the Fluency Icons Library Plugin
		
		Instructions:
			1. Select all the image buttons that you want to extract.
			2. Run the command.
			3. View output module in workspace.
	]]
	
	------------------------ COPY START -----------------------------------------------
	local Selections = game:GetService("Selection"):Get()
	
	local Ids = {}
	local TotalIds = 0
	
	for _, Selection in Selections do
		if((Selection:IsA("ImageButton") or Selection:IsA("ImageLabel")) == false) then
			warn(`Selected non image object: "{Selection:GetFullName()}", Will skip.`)
			continue
		end
		local NameFormatted = Selection.Name:gsub("%s", "-")
		Ids[NameFormatted] = Selection.Image
		TotalIds += 1
	end
	
	local OutputModule = Instance.new("ModuleScript")
	
	local TableSource = ""
	local index = 0
	for key, value in Ids do
		index += 1
		if(index == 1) then
			TableSource = `\t["{key}"] = "rbxassetid://{value}",`
			continue
		end
		TableSource = TableSource .. `\n\t["{key}"] = "{value}",`
	end
	
	OutputModule.Source = `-- This file was automatically generated\n-- Extracted on {DateTime.now():FormatUniversalTime("LLLL", "en-us")} UTC\n-- Generated with ❤️ @mekstuff\n\nreturn \{\n{TableSource}\n\}`
	
	OutputModule.Name = "Output"
	OutputModule.Parent = workspace
	
	game:GetService("Selection"):Set({OutputModule})
	
	print(`Completed extraction: {OutputModule:GetFullName()}`);
	------------------------ COPY END -----------------------------------------------
	
]=]
return nil
