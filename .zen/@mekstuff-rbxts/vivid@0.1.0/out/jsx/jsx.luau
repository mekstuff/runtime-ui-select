-- Compiled with roblox-ts v3.0.0-dev-d48bd20
local TS = _G[script]
local createState = TS.import(script, script.Parent.Parent, "create", "createState").createState
local createElement = TS.import(script, script.Parent.Parent, "create", "createElement").createElement
local createSwitch = TS.import(script, script.Parent.Parent, "conditionals", "createSwitch").createSwitch
local createSuspense = TS.import(script, script.Parent.Parent, "conditionals", "createSuspense").createSuspense
local forEach = TS.import(script, script.Parent.Parent, "functions", "forEach").forEach
local _FragmentIdentifier_ = TS.import(script, script.Parent.Parent, "internal", "Fragment")._FragmentIdentifier_
local createSlot = TS.import(script, script.Parent.Parent, "create", "createSlot").createSlot
local createPortal = TS.import(script, script.Parent.Parent, "create", "createPortal").createPortal
--[[
	
	export function JSX_Animate(props: { children?: unknown } & { [key: string]: unknown }) {
		const Fragment = createElement(
			_FragmentIdentifier_ as never,
			undefined,
			// props as never, // TODO: won't "children" try to parent itself? Check.
			props.children as never,
		) as _internal_fragment;
	
		const ObjectToAnimate = typeIs(Fragment.children, "Instance")
			? Fragment.children
			: typeIs(Fragment.children, "table")
			? (Fragment.children as Instance[])[0]
			: undefined;
		assert(
			typeIs(ObjectToAnimate, "Instance"),
			`<Animate/> expected Instance as child, got ${typeOf(ObjectToAnimate)} (${ObjectToAnimate})`,
		);
	
		return Fragment as unknown as Instance;
	}
	
]]
-- Animate exported and created in index.
local function JSX_Slot(props)
	return createSlot(props)
end
local function JSX_Portal(props)
	return createPortal(props)
end
local function JSX_Show(props)
	local Condition, setCondition = createState(false)
	-- const when = props.when;
	-- if (typeIs(when, "function")) {
	-- 	createEffect(() => {
	-- 		const res = when();
	-- 		assert(typeIs(res, "boolean"), "JSX_Show when() function didn't return a boolean");
	-- 		setCondition(res);
	-- 	});
	-- }
	local _ = createSwitch(props.when)
	local _children = props.children
	local Switch = _.Case(true, if type(_children) == "function" then (props.children) else (props.children)[1]).Case(false, _FragmentIdentifier_)
	return Switch()
	-- throw "JSX_Show not implemented.";
	-- return undefined as never;
	-- return createPromiseSuspense(
	-- 	() => {
	-- 		return new Promise((resolve) => {
	-- 			return resolve(props.when());
	-- 		});
	-- 	},
	-- 	(props.children as unknown as Record<number, Vivid.FC.Render>)[1],
	-- 	props.loading,
	-- 	props.fallback,
	-- 	true,
	-- )();
end
local function JSX_ForEach(props)
	local _object = {
		each = props.each,
		uniqueIdExtractor = props.uniqueIdExtractor,
	}
	local _left = "children"
	local _children = props.children
	_object[_left] = if type(_children) == "function" then (props.children) else (props.children)[1]
	local res = forEach(_object)()
	return res
end
local function JSX_Suspense(props)
	local _children = props.children
	return createSuspense(if type(_children) == "function" then (props.children) else (props.children)[1], props.loading, props.fallback)()
end
local function JSX_Switch(props)
	local Switch = createSwitch(props.conditional)
	local _exp = (props.children)
	-- ▼ ReadonlyArray.forEach ▼
	local _callback = function(child)
		if child._data_fields == nil then
			error("Missing _data_fields, May not be a <Case/>")
		end
		if child._data_fields.jsx_switchcase == nil then
			error("Missing jsx_switchcase, May not be a <Case/>")
		end
		Switch.Case(child._data_fields.jsx_switchcase.condition, child._data_fields.jsx_switchcase.render)
	end
	for _k, _v in _exp do
		_callback(_v, _k - 1, _exp)
	end
	-- ▲ ReadonlyArray.forEach ▲
	return Switch()
end
local function JSX_SwitchCase(props)
	local Fragment = createElement(_FragmentIdentifier_)
	Fragment._data_fields = Fragment._data_fields or {}
	Fragment._data_fields.jsx_switchcase = {
		render = (props.children)[1],
		condition = props.condition,
	}
	return Fragment
end
return {
	JSX_Slot = JSX_Slot,
	JSX_Portal = JSX_Portal,
	JSX_Show = JSX_Show,
	JSX_ForEach = JSX_ForEach,
	JSX_Suspense = JSX_Suspense,
	JSX_Switch = JSX_Switch,
	JSX_SwitchCase = JSX_SwitchCase,
}
