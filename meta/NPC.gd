extends Node

"""
	This script currently stores metadata for NPC.
"""

var meta = {
	"boat:pirate": {
		1: {
			"level": 1,
			"stats": {
				"damage": 1,
				"health": 5,
			},
			"items": {
				"rifle": 2,
				"sword": 5,
			},
			"coins": 1000,
		},
		2: {
			"level": 2,
			"stats": {
				"damage": 2,
				"health": 10,
			},
			"items": {
				"rifle": 4,
				"sword": 10,
			},
			"coins": 2000,
		},
	}
}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
