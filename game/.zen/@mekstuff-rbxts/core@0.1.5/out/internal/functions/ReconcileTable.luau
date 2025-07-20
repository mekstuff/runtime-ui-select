-- Compiled with roblox-ts v3.0.0
-- https://github.com/MadStudioRoblox/ProfileService/blob/master/ProfileService.lua#L503C1-L517C4
local function DeepCopyTable(t)
	local copy = {}
	for key, value in pairs(t) do
		if typeof(value) == "table" then
			copy[key] = DeepCopyTable(value)
		else
			copy[key] = value
		end
	end
	return copy
end
local function ReconcileTable(target, template, mutate)
	local t = if mutate == true then nil else {}
	target = if t ~= nil then t else target
	for k, v in pairs(template) do
		if typeof(k) == "string" then
			-- Only string keys will be reconciled
			if target[k] == nil then
				if typeof(v) == "table" then
					-- target[k] = DeepCopyTable(v as UA);
					target[k] = ReconcileTable(v, (if target[k] then table.clone(target[k]) else {}))
				else
					target[k] = v
				end
			else
				local _arg0 = target[k]
				local _condition = typeof(_arg0) == "table"
				if _condition then
					_condition = typeof(v) == "table"
				end
				if _condition then
					ReconcileTable(target[k], v)
				end
			end
		end
	end
	return t
end
return {
	ReconcileTable = ReconcileTable,
	DeepCopyTable = DeepCopyTable,
}
