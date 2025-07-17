/*
    Typed with ❤️ @mekstuff
    15/07/2025 18:07:05
*/

const ScriptEditorService = game.GetService("ScriptEditorService");

import { Engine } from "@mekstuff-rbxts/core";
import { Constants } from "Core/Constants/Constants";

export function GetPluginSharedSettingToken(): ModuleScript {
	let TargetSource = Engine.FetchReplicatedStorage().FindFirstChild(Constants.PluginSharedSettingTokenListener);
	if (TargetSource !== undefined && TargetSource.IsA("ModuleScript") === false) {
		TargetSource.Destroy();
		TargetSource = undefined;
	}
	if (TargetSource === undefined) {
		TargetSource = new Instance("ModuleScript");
		TargetSource.Name = Constants.PluginSharedSettingTokenListener;
		TargetSource.Parent = Engine.FetchReplicatedStorage();
	}
	return TargetSource as ModuleScript;
}

export function InsertPluginSharedSettingToken() {
	return GetPluginSharedSettingToken();
}

export function UpdatePluginSharedToken(OpenDocument: boolean) {
	Promise.try(() => {
		const PluginSharedSettingToken = GetPluginSharedSettingToken();
		if (OpenDocument === true) {
			const [Success, Results] = ScriptEditorService.OpenScriptDocumentAsync(
				PluginSharedSettingToken,
			) as LuaTuple<[boolean, unknown]>;

			if (Success === false) {
				throw `Could not OpenScriptDocumentAsync - ${Results}`;
			}
		}

		ScriptEditorService.UpdateSourceAsync(PluginSharedSettingToken, () => {
			return `
--[[
	* This file was automatically generated and should not be directly edited
	* This file allows runtime-ui-select to detect settings changes during runtime.
	* Generated with ❤️ @mekstuff
]]

return {
	stamp = ${DateTime.now().UnixTimestamp}
};
`;
		});

		if (OpenDocument === true) {
			const ScriptDocument = ScriptEditorService.FindScriptDocument(PluginSharedSettingToken);
			if (ScriptDocument === undefined) {
				throw `Could not FindScriptDocument`;
			}
			ScriptDocument.CloseAsync();
		}
	});
}
