extends Node

"""
	This script currently stores metadata for NPC.
"""

var meta = {
	"boat_pirate": {
		1: {
			"level": 1,
			"stats": {
				"damage": 1,
				"health": 5,
			},
			"items": [
				{
					"name": "coin",
					"amount": 1000,
				},
				{
					"name": "rifle",
					"amount": 2,
				},
				{
					"name": "sword",
					"amount": 5,
				},
			],
		},
		2: {
			"level": 2,
			"stats": {
				"damage": 2,
				"health": 10,
			},
			"items": [
				{
					"name": "coin",
					"amount": 1000,
				},
				{
					"name": "rifle",
					"amount": 4,
				},
				{
					"name": "sword",
					"amount": 10,
				},
			],
			"coin": 2000,
		},
	}
}

func get_pirate_boat(level):
	return meta["boat_pirate"][level]

func get_stats_damage(boat):
	return boat["stats"]["damage"]

func get_stats_health(boat):
	return boat["stats"]["health"]

func get_items(boat):
	return boat["items"]

func is_item_coins(item):
	return 
