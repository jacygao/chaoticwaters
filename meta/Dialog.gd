extends Node

"""
	This script currently stores metadata for Dialogs.
"""

var dialog = {
	0: [
		{
			"is_player_speaking": false,
			"name": "sailor",
			"portait_file_name": "portait-2,png",
			"text": "Captain, pirate ship spotted at 3 o'clock. Please give order!",
		},
		{
			"is_player_speaking": true,
			"name": "captain",
			"portait_path": "portait-1,png",
			"text": "Fire.",
		},
	],
}

func load_dialog(key):
	if dialog.has(key):
		return dialog[key]
	return {}
