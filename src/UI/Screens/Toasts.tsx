/*
    Typed with ❤️ @mekstuff
    13/07/2025 20:11:59
*/

const Players = game.GetService("Players");

import Vivid from "@mekstuff-rbxts/vivid";
import { CreateDismissToastProvider, CreateSendToastProvider, ToastsListProvider } from "@mekstuff-rbxts/vivid-ui";
import { Constants } from "Core/Constants/Constants";

const SendToastProvider = CreateSendToastProvider();
const DismissToastProvider = CreateDismissToastProvider();

export function Toasts() {
	const PlayerGui = Players.LocalPlayer.WaitForChild("PlayerGui");

	return (
		<screengui
			Parent={PlayerGui}
			Name={`${Constants.PluginDisplayName}-Toasts`}
			DisplayOrder={997}
			IgnoreGuiInset={true}
			ResetOnSpawn={false}
		>
			<ToastsListProvider
				sendToastProvider={SendToastProvider}
				dismissToastProvider={DismissToastProvider}
				BackgroundTransparency={1}
				Position={new UDim2(1, 0, 1, 0)}
				AnchorPoint={new Vector2(1, 1)}
				Size={new UDim2(0.4, 0, 1, 0)}
			/>
		</screengui>
	);
}

export const SendToast = SendToastProvider.callback;
export const DismissToast = DismissToastProvider.callback;
