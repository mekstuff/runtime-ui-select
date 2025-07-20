import { Pseudo, usePropertyEffectCleanup } from "../Pseudo/Pseudo";
import { State } from "../State/State";
type ObserveObjectCallback<T> = (Object: T) => usePropertyEffectCleanup;
export declare class ObservablesClass extends Pseudo {
    ObserveCharacter(Player: Player, Callback?: ObserveObjectCallback<Model>): State<Model>;
    ObserveHumanoid(Player: Player, Callback?: ObserveObjectCallback<Humanoid>): State<Humanoid>;
    ObserveHumanoidRootPart(Player: Player, Callback?: ObserveObjectCallback<Part>): State<Part>;
    constructor();
}
declare const Observables: ObservablesClass;
export { Observables };
export default Observables;
