extends Node

"""
	Metadata for items
"""

var meta = {
	"coin": {
		"name": "coin",
		"image": "coins.png",
		"value": 1,
	},
	"rifle": {
		"name": "rifle",
		"image": "winchester-rifle.png",
		"value": 1200,
	},
	"sword": {
		"name": "sword",
		"image": "sword-array.png",
		"value": 700,
	},
	"fish": {
		"name": "fish",
		"image": "fish.png",
		"value": 120,
	},
	"bread": {
		"name": "bread",
		"image": "bread.png",
		"value": 180,
	},
	"wood": {
		"name": "wood",
		"image": "wood.png",
		"value": 600,
	},
	"weapon": {
		"name": "weapon",
		"image": "weapon.png",
		"value": 800,
	},
	"bronze": {
		"name": "bronze",
		"image": "bronze.png",
		"value": 1200,
	},
}

func get(name):
	if meta.has(name):
		return meta[name]
	return {}
	
func get_image(item:Dictionary):
	if item.has("image"):
		return item["image"]
	return ""

func get_value(item:Dictionary):
	if item.has("value"):
		return item["value"]
	return 0

func get_item_name(item):
	if item.has("name"):
		return item["name"]
	return ""

func is_item_coin(item):
	return item["name"] == "coin"

func get_item_amount(item):
	return item["amount"]
