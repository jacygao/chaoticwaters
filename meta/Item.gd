extends Node

"""
	Metadata for items
"""

var meta = {
	"rifle": {
		"image": "winchester-rifle.png",
		"value": 1200,
	},
	"sword": {
		"image": "sword-array.png",
		"value": 700,
	},
}

func get(name):
	if meta.has(name):
		return meta[name]
	return {}
