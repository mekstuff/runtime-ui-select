-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	
		Typed with ❤️ @mekstuff
		18/12/2024 12:47:03
	
		Servant is now ServantNext. View ServantNext.luau
	
]]
local ServantNext = TS.import(script, script.Parent, "ServantNext").ServantNext
local Servant
local function ServantPromise(callback)
	return function(resolve, reject, onCancel)
		local executionServant = Servant.new()
		local customResolve = function(value)
			if executionServant ~= nil then
				resolve(value)
				executionServant:Destroy()
				executionServant = nil
			end
		end
		local customReject = function(value)
			if executionServant ~= nil then
				reject(value)
				executionServant:Destroy()
				executionServant = nil
			end
		end
		if executionServant ~= nil then
			executionServant:Keep(function(threader)
				local s, r = pcall(function()
					callback(customResolve, customReject, onCancel, executionServant, threader)
				end)
				if s == false then
					customReject(r)
				end
			end)
		end
	end
end
Servant = ServantNext
-- //@todo - FIX: Servant:Keep(...) with multiple items seems to fail to cleanup them properly consistenly.
-- import { threader } from "@mekstuff-rbxts/threader";
-- import { Pseudo } from "../Pseudo/Pseudo";
-- import { _typeIs } from "../../internal/functions/typeIs";
-- /**
--  * A `Servant-Promise`.
--  *
--  * When the `Promise` is `resolved` or `rejected`, the execution thread will stop executing
--  *
--  * `sp` also has a 4th param of `servant` which is a `Servant` that can be used during the lifetime of the execution thread.
--  * It is useful for storing objects/connections that are related to the running Promise.
--  *
--  * Your callback is wrapped inside of a `threader`.
--  *
--  * To end execution thread on cancel, you need to manually do it
--  *
--  * ```ts
--  * new Promise<void>(
--  * 	sp((_, __, onCancel, PromiseServant, PromiseThreader)
--  * 		onCancel(() => {
--  * 			PromiseServant.Destroy(); //Destroys the servant, and stops the PromiseThreader, this is the recommended method
--  * 			PromiseThreader.tryClose(); //Closes the threader, if you chose to do it this way remember to cleanup the PromiseServant sufficiently
--  * 		});
--  * 	}),
--  * );
--  * ```
--  */
-- export class Servant extends Pseudo<{
-- 	_servanttracker: Record<string | number, ServantTrackableItem>;
-- }> {
-- 	public Destroy() {}
-- 	/**
-- 	 * Executes function within a "threader"
-- 	 */
-- 	public Execute(Func: Callback): threader {
-- 		const thread = new threader(Func, undefined, true);
-- 		thread.active = true;
-- 		return this.Keep(thread)[0];
-- 	}
-- 	/**Connects to the script signal then calls :Keep on the connection*/
-- 	Connect(Signal: RBXScriptSignal<Callback>, Callback: Callback): LuaTuple<ServantTrackableItem[]> {
-- 		return this.Keep(Signal.Connect(Callback));
-- 	}
-- 	public Add(...args: Parameters<Servant["Keep"]>): ReturnType<Servant["Keep"]> {
-- 		return this.Keep(...args);
-- 	}
-- 	Keep<T extends ServantTrackableItem>(TrackableId: string, TrackableItem: T): T;
-- 	Keep<T extends ServantTrackableItem[]>(...TrackableItems: T): LuaTuple<T>;
-- 	/**
-- 	 * The Item will be cleaned up with the `Servant` when destroyed.
-- 	 */
-- 	Keep(
-- 		TrackId: string | ServantTrackableItem,
-- 		...TrackableItems: ServantTrackableItem[]
-- 	): LuaTuple<unknown[]> | unknown {
-- 		let _noadd = false;
-- 		if (this._dev === undefined || this._dev._destroyed === true) {
-- 			// If the Pseudo was destroyed already, automatically Free and clean these new additions instantly.
-- 			this.warn(
-- 				`new Trackable items will be dropped instantly as the Servant was Destroyed prior to the requests.`,
-- 			);
-- 			TrackableItems.forEach((_, b) => {
-- 				this._DestroyTrackedItem(b);
-- 			});
-- 			if (!typeIs(TrackId, "string")) {
-- 				this._DestroyTrackedItem(TrackId);
-- 			}
-- 			return;
-- 			// this.Clean();
-- 			// _noadd = true;
-- 		}
-- 		const servanttracker = this._dev._servanttracker;
-- 		const add_trackable_item = (item: ServantTrackableItem, id: string) => {
-- 			let pushValue: ServantTrackableItem = item;
-- 			if (typeIs(item, "function")) {
-- 				/* Previously, function passed into Keep will create a new threader, as of 8/18/2024, passing a function to Keep will threat it as a cleanup function. Using :Execute for the previous behavior
-- 				const thread = new threader(
-- 					() => {
-- 						item(thread);
-- 					},
-- 					undefined,
-- 					true,
-- 				);
-- 				pushValue = thread;
-- 				thread.active = true;
-- 				*/
-- 				pushValue = this.Destroying.Connect(() => {
-- 					item();
-- 				});
-- 			}
-- 			if (typeIs(item, "Instance") || _typeIs(item, "Pseudo")) {
-- 				item;
-- 				const trackInstanceDestroyedId = id + `-instance-track`;
-- 				const k = this.Keep(
-- 					trackInstanceDestroyedId,
-- 					item.Destroying.Connect(() => {
-- 						this.Free(TrackId, trackInstanceDestroyedId);
-- 						this.Free(k);
-- 					}),
-- 				);
-- 			}
-- 			servanttracker[id] = pushValue;
-- 		};
-- 		if (typeIs(TrackId, "string")) {
-- 			const TrackableItem = TrackableItems[0];
-- 			assert(
-- 				TrackableItems,
-- 				'You need to provide a trackable item as the second argument whenever you\'re using "Keep" with the first argument being a string (id)',
-- 			);
-- 			if (servanttracker[TrackId] !== undefined) {
-- 				warn(
-- 					`Conflict with :Keep track ids, the id "${TrackableItem}" already existed, the previous element will be free`,
-- 				);
-- 				this.Free(TrackableItem);
-- 			}
-- 			if (!_noadd) {
-- 				add_trackable_item(TrackableItem, TrackId);
-- 			}
-- 			return TrackableItems;
-- 		}
-- 		if (!_noadd) {
-- 			TrackableItems.push(TrackId);
-- 			TrackableItems.forEach((e) => {
-- 				add_trackable_item(e, tostring(math.random()));
-- 				// this._dev._servanttracker[tostring(math.random())] = pushValue;
-- 			});
-- 		}
-- 		return $tuple(...TrackableItems);
-- 	}
-- 	/**
-- 	 * "Frees" the trackable item, meaning it will not be cleaned up now or whenever the `Servant` is destroyed, it will no longer be bounded to the `Servant`.
-- 	 */
-- 	Free(...TrackableItems: (string | ServantTrackableItem)[]): void {
-- 		const servanttracker = this._dev._servanttracker;
-- 		if (!servanttracker) {
-- 			return;
-- 		}
-- 		// No idea why _DestroyTrackedItem() is called here... ServantNext removes that.
-- 		TrackableItems.forEach((e) => {
-- 			if (typeIs(e, "string")) {
-- 				this._DestroyTrackedItem(servanttracker[e]);
-- 				delete servanttracker[e];
-- 			} else {
-- 				for (const [i, b] of pairs(servanttracker)) {
-- 					if (b === e) {
-- 						this._DestroyTrackedItem(b);
-- 						delete servanttracker[i];
-- 						break;
-- 					}
-- 				}
-- 			}
-- 		});
-- 	}
-- 	/**
-- 	 * Disconnect/Destroyes/Cleansup the item
-- 	 *
-- 	 * You can pass the item or the unique identifier for that item if any.
-- 	 *
-- 	 * ```ts
-- 	 * mainServant.Keep(
-- 	 *	game.Workspace.GetPropertyChangedSignal("DistributedGameTime").Connect(() => {
-- 	 *		print(game.Workspace.DistributedGameTime);
-- 	 *	}),
-- 	 *		"uid",
-- 	 *	);
-- 	 *
-- 	 *	task.delay(4, () => {
-- 	 *		mainServant.Purge("uid");
-- 	 *  });
-- 	 *
-- 	 *```
-- 	 */
-- 	Purge(...TrackableItems: (string | ServantTrackableItem)[]): void {
-- 		const servanttracker = this._dev._servanttracker;
-- 		TrackableItems.forEach((e) => {
-- 			if (typeIs(e, "string")) {
-- 				this._DestroyTrackedItem(servanttracker[e]);
-- 				delete servanttracker[e];
-- 			} else {
-- 				for (const [i, b] of pairs(servanttracker)) {
-- 					if (b === e) {
-- 						this._DestroyTrackedItem(b);
-- 						delete servanttracker[i];
-- 						break;
-- 					}
-- 				}
-- 			}
-- 		});
-- 	}
-- 	/**
-- 	 * This will go through all tracked items and if they are no longer operational they will be removed from the tracked item list for them to
-- 	 * be properly garbaged collected.
-- 	 */
-- 	Clean() {
-- 		// no need to clean Instances/Pseudos since they are immediately cleaned when destroyed.
-- 		const servanttracker = this._dev._servanttracker;
-- 		if (!servanttracker) {
-- 			return;
-- 		}
-- 		for (const [i, v] of pairs(servanttracker)) {
-- 			if (typeIs(v, "RBXScriptConnection")) {
-- 				if (v.Connected === false) {
-- 					delete servanttracker[i];
-- 				}
-- 				continue;
-- 			}
-- 		}
-- 	}
-- 	//
-- 	_DestroyTrackedItem(Item: unknown): void {
-- 		type DestructableItem = {
-- 			Destroy?: () => void;
-- 			Disconnect?: () => void;
-- 		};
-- 		if (Item !== undefined) {
-- 			if (typeIs(Item, "RBXScriptConnection")) {
-- 				Item.Disconnect();
-- 				return;
-- 			} else if (typeIs(Item, "Instance")) {
-- 				pcall(() => {
-- 					Item.Destroy();
-- 				});
-- 				return;
-- 			}
-- 			const destructable: DestructableItem = Item as DestructableItem;
-- 			pcall(() => {
-- 				if (destructable.Destroy) {
-- 					destructable.Destroy();
-- 				}
-- 				if (destructable.Disconnect) {
-- 					destructable.Disconnect();
-- 				}
-- 			});
-- 		}
-- 	}
-- 	constructor() {
-- 		super("Servant");
-- 		this._dev._servanttracker = {};
-- 	}
-- }
return {
	Servant = Servant,
	ServantPromise = ServantPromise,
}
