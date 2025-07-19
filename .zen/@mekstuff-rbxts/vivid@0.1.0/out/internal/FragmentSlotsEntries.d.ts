import { Signal } from "@mekstuff-rbxts/core";
type FragmentSlotSignal = Signal<(SlotId: string) => void>;
export declare const GetFragmentSlotEntryAddedSignal: () => FragmentSlotSignal;
export declare const FireSlotEntryAddedSignal: (SlotId: string) => void;
export declare const FragmentSlotEntries: Record<string, unknown>;
export {};
