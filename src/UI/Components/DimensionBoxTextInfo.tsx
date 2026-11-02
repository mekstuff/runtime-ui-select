/*
    Typed with ❤️ @mekstuff
    13/07/2025 20:21:28
*/

const TextService = game.GetService("TextService");

import Vivid, {
	Case,
	createEffect,
	createRef,
	createState,
	Switch,
	withProps,
	WithTransition,
} from "@mekstuff-rbxts/vivid";
import { Button, ButtonProps, Theme, Units } from "@mekstuff-rbxts/vivid-ui";
import { Constants } from "Core/Constants/Constants";
import { Tags } from "Core/Constants/Tags";

export function DimensionBoxTextInfo(props: ButtonProps & { truthy: boolean }) {
	const Properties = withProps(props, true) as Partial<typeof props>;
	delete Properties.truthy;

	const ButtonRef = createRef<TextButton>();
	const [TextBounds, setTextBounds] = createState(new Vector2(0, 0));

	createEffect(() => {
		const BtnRef = ButtonRef();
		if (BtnRef === undefined) {
			return;
		}
		const TextBoundsParams = new Instance("GetTextBoundsParams");
		TextBoundsParams.Size = (props.TextSize ?? BtnRef.TextSize) as typeof BtnRef.TextSize;
		TextBoundsParams.Font = (props.FontFace ?? BtnRef.FontFace) as typeof BtnRef.FontFace;
		TextBoundsParams.RichText = (props.RichText ?? BtnRef.RichText) as typeof BtnRef.RichText;
		TextBoundsParams.Text = (props.Text ?? BtnRef.Text) as typeof BtnRef.Text;
		TextBoundsParams.Width = 10e10;
		task.spawn(() => {
			setTextBounds(TextService.GetTextBoundsAsync(TextBoundsParams));
		});
	});

	return (
		<Switch conditional={createEffect(() => props.truthy === true)()}>
			<Case condition={true}>
				{() => (
					<Button
						tags={[Tags.IgnoreHoverDetection]}
						variant="ghost"
						padding={0}
						props={{
							IconImage: {
								tags: [Tags.IgnoreHoverDetection],
							},
							SpinnerContainer: {
								tags: [Tags.IgnoreHoverDetection],
							},
							TextLabel: {
								tags: [Tags.IgnoreHoverDetection],
							},
						}}
						BackgroundTransparency={1}
						TextColor3={Theme().SubText}
						TextSize={createEffect(() => Units().BaseTextSize - 1)()}
						TextTruncate={Enum.TextTruncate.None}
						AutomaticSize={Enum.AutomaticSize.None}
						Size={createEffect(() => UDim2.fromOffset(TextBounds().X, TextBounds().Y))()}
						TextTransparency={createEffect(() => {
							return WithTransition(0, {
								DefaultValue: 1,
							});
						})}
						forwardRef={props.ref}
						{...Properties}
						ref={ButtonRef}
					/>
				)}
			</Case>
			<Case condition={false}>{() => <></>}</Case>
		</Switch>
	);
}
