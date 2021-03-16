extends Node

"""
Research implements a dictionary that stores research progression.
Key - string
Represents the name of a research item.
Value - int
Represents the level of a research item.
"""

var research = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func upgrade(key):
	if !research.has(key):
		research[key] = 1
	else:
		research[key] = research[key]+1

func get_level(key):
	if !research.has(key):
		return 0
	else:
		return research[key]
