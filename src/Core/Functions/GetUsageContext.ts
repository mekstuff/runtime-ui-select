/*
    Typed with ❤️ @mekstuff
    02/07/2025 22:13:36
*/

const RunService = game.GetService("RunService");

export function GetIsStudio(): boolean {
	return RunService.IsStudio();
}

export function GetIsClient(): boolean {
	return RunService.IsClient();
}

export function GetIsRunningSession(): boolean {
	return RunService.IsEdit() === false && GetIsStudio() === true && GetIsClient() === true;
}
export function GetIsRunningSessionServer(): boolean {
	return RunService.IsEdit() === false && GetIsStudio() === true && GetIsClient() === false;
}

export function GetIsNonPluginEnv(): boolean {
	if (GetIsStudio() === false) {
		return true;
	}
	return script.FindFirstAncestorWhichIsA("Plugin") === undefined;
}
