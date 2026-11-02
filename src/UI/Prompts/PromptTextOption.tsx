/*
    Typed with ❤️ @mekstuff
    16/07/2025 22:45:10
*/

import Vivid, { createScope, Portal } from "@mekstuff-rbxts/vivid";
import { Button, ModalPrompt } from "@mekstuff-rbxts/vivid-ui";
import { Constants } from "Core/Constants/Constants";

export function PromptTextOption(props: { title: string; body: string; onOption: (option: boolean) => void }) {
	const PromptScope = createScope();

	<Portal slot="#root">
		<ModalPrompt
			opened
			title={props.title}
			body={props.body}
			buttons={[
				<Button
					Activated={() => {
						PromptScope.Destroy();
						props.onOption(false);
					}}
					color="default"
					Text={"Cancel"}
				></Button>,
				<Button
					Activated={() => {
						PromptScope.Destroy();
						props.onOption(true);
					}}
					color="primary"
					Text={"Accept"}
				></Button>,
			]}
		/>
	</Portal>;

	PromptScope.Close();
}
