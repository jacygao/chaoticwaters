extends Node

"""
	Metadata for items
"""

var meta = {
	"coin": {
		"name": "Coin",
		"image": "coins.png",
		"value": 1,
	},
	"rifle": {
		"name": "Rifle",
		"image": "winchester-rifle.png",
		"value": 1200,
	},
	"sword": {
		"name": "Sword",
		"image": "sword-array.png",
		"value": 700,
	},
	"fish": {
		"name": "Fish",
		"image": "fish.png",
		"value": 120,
	},
	"bread": {
		"name": "Bread",
		"image": "bread.png",
		"value": 180,
	},
	"wood": {
		"name": "Wood",
		"image": "wood.png",
		"value": 600,
	},
	"weapon": {
		"name": "Weapon",
		"image": "weapon.png",
		"value": 800,
	},
	"bronze": {
		"name": "Bronze",
		"image": "bronze.png",
		"value": 1200,
	},
	"fur": {
		"name": "Fur",
		"image": "fur.png",
		"value": 1400,
	},
	"grain": {
		"name": "Grain",
		"image": "grain.png",
		"value": 120,
	},
	"wax": {
		"name": "Wax",
		"image": "wax.png",
		"value": 400,
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
