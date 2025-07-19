-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
-- import { useEffectServant } from "../../class/Pseudo/Pseudo";
local _typeIs = TS.import(script, script.Parent, "typeIs")._typeIs
local errorp = TS.import(script, script.Parent.Parent, "debug", "debug").errorp
local tryUseEffectCleanup
tryUseEffectCleanup = function(_cleanup, isDestroying, errorTraceback)
	local __cleanup = _cleanup
	local _condition = type(__cleanup) == "table"
	if _condition then
		_condition = not _typeIs(_cleanup, "Pseudo") and not _typeIs(_cleanup, "SignalConnection")
	end
	if _condition then
		--tuple
		for _, v in pairs(_cleanup) do
			tryUseEffectCleanup(v, isDestroying)
		end
		return nil
	end
	local __cleanup_1 = _cleanup
	if type(__cleanup_1) == "function" then
		return _cleanup(isDestroying)
	elseif TS.Promise.is(_cleanup) then
		if _cleanup:getStatus() == "Started" then
			warn(`Unresolved Promise {tostring(_cleanup)} from useEffectServant will be cancelled.`)
			_cleanup:cancel()
		end
		return nil
	elseif _typeIs(_cleanup, "Servant") then
		_cleanup:Destroy()
		return nil
	elseif _typeIs(_cleanup, "SignalConnection") then
		_cleanup:Disconnect()
		return nil
	else
		local __cleanup_2 = _cleanup
		if typeof(__cleanup_2) == "RBXScriptConnection" then
			_cleanup:Disconnect()
			return nil
		end
	end
	if _cleanup == nil then
		return nil
	end
	errorp(`Invalid cleanup object received: [[ {_cleanup} ]]. expected either: function, Servant, Promise, Connections or nil.\n\nStack Trace: {errorTraceback}`)
end
-- export function CalluseEffectServant(
-- 	ueServant: useEffectServant,
-- 	isDestroying?: boolean,
-- 	onlyCleanup?: boolean,
-- 	errorTraceback?: string,
-- ) {
-- 	const [s, r] = pcall(() => {
-- 		if (!ueServant._dev || !ueServant._dev.___ue) {
-- 			return;
-- 		}
-- 		const _cleanup = ueServant._dev.___ue.cleanup;
-- 		if (_cleanup) {
-- 			tryUseEffectCleanup(_cleanup, isDestroying);
-- 		}
-- 		if (!ueServant._dev || !ueServant._dev.___ue) {
-- 			return;
-- 		}
-- 		/* executing servant param was removed.
-- 		if (ueServant._dev.___ue.executingServants) {
-- 			for (const [_, s] of pairs(ueServant._dev.___ue.executingServants)) {
-- 				s.Destroy();
-- 			}
-- 			ueServant._dev.___ue.executingServants = undefined;
-- 		}
-- 		ueServant._dev.___ue.cleanup = undefined;
-- 		const [executingServant] = ueServant.Keep(CreateServant());
-- 		if(!executingServant || executingServant._destroyed || !executingServant._dev) {
-- 			return;
-- 		}
-- 		ueServant._dev.ue.executingServants = ueServant._dev.ue.executingServants ?? {};
-- 		ueServant._dev.ue.executingServants[executingServant._id] = executingServant;
-- 		const results = ueServant._dev.ue.cb(executingServant);
-- 		*/
-- 		if (onlyCleanup) {
-- 			if (isDestroying) {
-- 				ueServant._dev.___ue = undefined as never; // cleanup ___ue since .Destroy() ignores it.
-- 			}
-- 			return;
-- 		}
-- 		const cbid = tick();
-- 		ueServant._dev.___ue.cbid = cbid;
-- 		const results = [ueServant._dev.___ue.cb()];
-- 		if (!ueServant._dev || !ueServant._dev.___ue) {
-- 			return;
-- 		}
-- 		if (ueServant._dev.___ue.cbid !== cbid) {
-- 			// another call for the cb was made before a previous cb finished executing.
-- 			tryUseEffectCleanup(results, isDestroying, errorTraceback);
-- 			return;
-- 		}
-- 		if (typeIs(results, "function")) {
-- 			ueServant._dev.___ue.cleanup = results;
-- 		} else if (Promise.is(results)) {
-- 			ueServant._dev.___ue.cleanup = results;
-- 		} else if (_typeIs(results, "Servant")) {
-- 			ueServant._dev.___ue.cleanup = results;
-- 		} else if (_typeIs(results, "table")) {
-- 			ueServant._dev.___ue.cleanup = results as LuaTuple<unknown[]>;
-- 		} else {
-- 			if (results !== undefined) {
-- 				warn(
-- 					`Unknown return type from usePropertyEffect!, Got ${typeOf(
-- 						results,
-- 					)}, but expected either: function, Servant, Promise, Connections or nil.\n\nStack Trace: ${errorTraceback}`,
-- 				);
-- 			}
-- 		}
-- 	});
-- 	if (!s) {
-- 		ueServant.error(`Failed to execute useEffect on ${ueServant} :: ${r}\n\nStack Trace: ${errorTraceback}`);
-- 		// throw `ERROR Occurred when executing your useEffect "${tostring(ueServant)}": ${r}`;
-- 	}
-- }
return {
	tryUseEffectCleanup = tryUseEffectCleanup,
}
