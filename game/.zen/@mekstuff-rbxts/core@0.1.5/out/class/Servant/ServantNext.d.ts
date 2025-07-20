/*
    Typed with ❤️ @mekstuff
    17/12/2024 23:43:25
*/

import { threader } from "@mekstuff-rbxts/threader";
import { ServantTrackableItem } from "./Servant";
import { PseudoNext } from "../Pseudo/PseudoNext";

type ServantNext = {
	Destroy(): void;

	Execute(Func: Callback): threader;

	Keep<T extends ServantTrackableItem>(TrackableId: string, TrackableItem: T): T;
	Keep<T extends ServantTrackableItem[]>(...TrackableItems: T): LuaTuple<T>;
	/**
	 * The Item will be cleaned up with the `Servant` when destroyed.
	 */
	Keep(
		TrackId: string | ServantTrackableItem,
		...TrackableItems: ServantTrackableItem[]
	): LuaTuple<unknown[]> | unknown;

	/**
	 * "Frees" the trackable item, meaning it will not be cleaned up now or whenever the `Servant` is destroyed, it will no longer be bounded to the `Servant`.
	 */
	Free(...TrackableItems: (string | ServantTrackableItem)[]): void;

	/**
	 * Disconnect/Destroyes/Cleansup the item
	 *
	 * You can pass the item or the unique identifier for that item if any.
	 *
	 * ```ts
	 * mainServant.Keep(
	 *	game.Workspace.GetPropertyChangedSignal("DistributedGameTime").Connect(() => {
	 *		print(game.Workspace.DistributedGameTime);
	 *	}),
	 *		"uid",
	 *	);
	 *
	 *	task.delay(4, () => {
	 *		mainServant.Purge("uid");
	 *  });
	 *
	 *```
	 */
	Purge(...TrackableItems: (string | ServantTrackableItem)[]): void;

	/**
	 * Using this function in ServantNext will throw an error. Servants should
	 * only exist for the time they're needed. "Cleaning" a Servant to continue using
	 * it should not be done. Instead Destroying said Servant and creating a new one for
	 * another task should be the norm.
	 *
	 * @deprecated
	 *
	 * This will go through all tracked items and if they are no longer operational they will be removed from the tracked item list for them to
	 * be properly garbaged collected.
	 */
	Clean(): void;
} & PseudoNext;

export interface ServantNextConstructor {
	new (): ServantNext;
}

declare const ServantNext: ServantNextConstructor;

export { ServantNext };
