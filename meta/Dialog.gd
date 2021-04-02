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
			"text": "Yes sir!",
		},
	],
}

func load_dialog(key):
	if dialog.has(key):
		return dialog[key]
	return {}
