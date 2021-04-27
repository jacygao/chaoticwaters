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
				"name": "sailor",
				"portrait_file_name": "portrait-2-3.png",
				"text": "Captain, the crew had a great nap and look energized!",
			},
			{
				"is_player_speaking": false,
				"name": "sailor",
				"portrait_file_name": "portrait-2-2.png",
				"text": "The next thing to do is repairing the ship. Let's go and speak to the Shipyard owner.",
			},
		],
		"once": true,
	},
	"first_occupation": {
		"dialog": [
			{
				"is_player_speaking": false,
				"name": "sailor",
				"portrait_file_name": "portrait-2-2.png",
				"text": "Captain, there will be much stronger enemies coming after us. To be prepared, we must grow our power.",
			},
			{
				"is_player_speaking": false,
				"name": "sailor",
				"portrait_file_name": "portrait-2-2.png",
				"text": "The first step to a strong navy is to build a strong wealth.",
			},
			{
				"is_player_speaking": false,
				"name": "sailor",
				"portrait_file_name": "portrait-2-2.png",
				"text": "Coins are the most important resource and can be made via trading goods between cities.",
			},
			{
				"is_player_speaking": false,
				"name": "sailor",
				"portrait_file_name": "portrait-2-2.png",
				"text": "But before we can make any trade, we must have occupied the city.",
			},
		],
		"once": true,
	},
	"first_trade": {
		"dialog": [
			{
				"is_player_speaking": false,
				"name": "sailor",
				"portrait_file_name": "portrait-2-3.png",
				"text": "Captain, we have been officially given the green light to trade in this city. Let's visit the Exchange Center and sell the loot from the battle earlier on.",
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
	"after_city_investment": {
		"dialog": [
			{
				"is_player_speaking": false,
				"name": "governer",
				"portrait_file_name": "portrait-4-3.png",
				"text": "Very Ambitious. I respect that.",
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
	"city_shop": {
		"dialog": [
			{
				"is_player_speaking": false,
				"name": "owner",
				"portrait_file_name": "portrait-7-3.png",
				"text": "Oh foreigners! You must be intereted in these locally made fabric!",
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
