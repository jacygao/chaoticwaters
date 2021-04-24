extends Node

"""
	This script currently stores metadata for Dialogs.
"""

var dialog = {
	"game_start": {
		"dialog": [
			{
				"is_player_speaking": false,
				"name": "sailor",
				"portrait_file_name": "portrait-2-4.png",
				"text": "Captain, pirate ship spotted at 3 o'clock. Please give order!",
			},
		],
		"once": true,
	},
	"first_victory": {
		"dialog":[
			{
				"is_player_speaking": false,
				"name": "pirate",
				"portrait_file_name": "portrait-3-4.png",
				"text": "Damn you!",
			},
			{
				"is_player_speaking": false,
				"name": "sailor",
				"portrait_file_name": "portrait-2-4.png",
				"text": "Good job captain! The enemy boat is sinking. Let's loot the boat before it is under the ocean.",
			},
		],
		"once": true,
	},
	"first_reward": {
		"dialog": [
			{
				"is_player_speaking": false,
				"name": "pirate",
				"portrait_file_name": "portrait-2-2.png",
				"text": "Captain, our ship took some damage during the battle and the crew is exausted. We should sail towards Stockholm to get some rest and repair the ship.",
			},
		],
		"once": true,
	},
	"first_city_visit": {
		"dialog": [
			{
				"is_player_speaking": false,
				"name": "pirate",
				"portrait_file_name": "portrait-2-2.png",
				"text": "Captain, the crew is exausted, let's get some rest in a hotel.",
			},
		],
		"once": true,
	},
	"first_shipyard_visit": {
		"dialog": [
			{
				"is_player_speaking": false,
				"name": "pirate",
				"portrait_file_name": "portrait-2-3.png",
				"text": "Captain, the crew had a great nap and look energized!",
			},
			{
				"is_player_speaking": false,
				"name": "pirate",
				"portrait_file_name": "portrait-2-2.png",
				"text": "The next thing to do is repairing the ship. Let's go and speak to the Shipyard owner.",
			},
		],
		"once": true,
	},
	"city_investment": {
		"dialog": [
			{
				"is_player_speaking": false,
				"name": "governer",
				"portrait_file_name": "portrait-4-1.png",
				"text": "Oh, I heard you want to make an investment on the city defence?",
			},
		],
		"once": false,
	},
	"city_hotel": {
		"dialog": [
			{
				"is_player_speaking": false,
				"name": "girl",
				"portrait_file_name": "portrait-5-4.png",
				"text": "Need a room?",
			},
		],
		"once": false,
	},
	"city_shipyard": {
		"dialog": [
			{
				"is_player_speaking": false,
				"name": "owner",
				"portrait_file_name": "portrait-6-2.png",
				"text": "How can I help you?",
			},
		],
		"once": false,
	},
}

func load_dialog(key):
	if dialog.has(key):
		return dialog[key]["dialog"]
	return {}

func is_once(key):
	if dialog.has(key):
		return dialog[key]["once"]
	return false
