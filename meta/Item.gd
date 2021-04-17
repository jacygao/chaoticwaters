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
}

func get(name):
	if meta.has(name):
		return meta[name]
	return {}
	
func get_image(item):
	if item.has("image"):
		return item["image"]
	return {}

func get_item_name(item):
	if item.has("name"):
		return item["name"]
	return {}

func is_item_coin(item):
	return item["name"] == "coin"

func get_item_amount(item):
	return item["amount"]
