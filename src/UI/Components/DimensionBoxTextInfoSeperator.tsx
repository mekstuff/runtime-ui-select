/*
    Typed with ❤️ @mekstuff
    13/07/2025 20:22:57
*/

import Vivid, { withProps } from "@mekstuff-rbxts/vivid";
import { Theme } from "@mekstuff-rbxts/vivid-ui";

export function DimensionBoxTextInfoSeperator(props: Vivid.FC.InstanceProperties<Frame>) {
	return (
		<frame
			Size={new UDim2(0, 1, 1, 0)}
			BackgroundColor3={Theme().SubText}
			BorderSizePixel={0}
			{...withProps(props, true)}
		/>
	);
}
