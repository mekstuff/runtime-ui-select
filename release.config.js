const config = {
	branches: ["main"],
	plugins: [
		"@semantic-release/commit-analyzer",
		"@semantic-release/release-notes-generator",
		["@semantic-release/changelog", { changelogFile: "CHANGELOG.md" }],
		"@semantic-release/npm",
		[
			"@semantic-release/git",
			{
				assets: ["out/rutus_plugin.rbxm", "game/out/rutus_game.rbxm", "CHANGELOG.md"],
				message: "chore(release): ${nextRelease.version} [skip ci]\n\n${nextRelease.notes}",
			},
		],
		[
			"@semantic-release/github",
			{
				assets: [
					{ path: "out/rutus_plugin.rbxm", label: "Rutus Plugin" },
					{ path: "game/out/rutus_game.rbxm", label: "Rutus Demo Game" },
				],
			},
		],
	],
};

module.exports = config;
