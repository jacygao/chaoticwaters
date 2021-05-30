extends Node

"""
	metadata for ships
"""

var asset_path = "res://assets/world/ship/"

var meta = {
	"brigantine": {
		"asset_file": "Brigantine.png",
	},
	"1st_rate_priate": {
		"asset_file": "1stRate-Pirate.png",
	},
	"wrack": {
		"asset_file": "wrack.png",
	},
}

func get_asset_path(boat_id):
	return asset_path+meta[boat_id]["asset_file"]
