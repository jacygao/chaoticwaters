extends Node

"""
	This script currently stores metadata for Dialogs.
"""

var dialog = {
	"game_start": [
		{
			"is_player_speaking": false,
			"name": "sailor",
			"portrait_file_name": "portait-2-4.png",
			"text": "Captain, pirate ship spotted at 3 o'clock. Please give order!",
		},
		{
			"is_player_speaking": true,
			"name": "captain",
			"portrait_file_name": "portait-1-2.png",
			"text": "Fire.",
		},
		{
			"is_player_speaking": false,
			"name": "sailor",
			"portrait_file_name": "portait-2-4.png",
			"text": "Yes captain!",
		},
	],
	"first_victory": [
		{
			"is_player_speaking": false,
			"name": "pirate",
			"portrait_file_name": "portait-3-4.png",
			"text": "Damn you!",
		},
		{
			"is_player_speaking": false,
			"name": "sailor",
			"portrait_file_name": "portait-2-4.png",
			"text": "Good job captain! The enemy boat is sinking. Let's loot the boat before it is under the ocean.",
		},
	],
	"first_reward": [
		{
			"is_player_speaking": false,
			"name": "pirate",
			"portrait_file_name": "portait-2-2.png",
			"text": "Captain, our ship took some damage during the battle and the crew are exausted. We should sail towards Stockholm to get some rest and repair the ship.",
		},
	]
}

func load_dialog(key):
	if dialog.has(key):
		return dialog[key]
	return {}
