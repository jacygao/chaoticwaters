extends Node

"""
	The root of the save system storing top level player data
"""

var player = {
	"tutorial_on": true,
}

func set_tutorial_off():
	player["tutorial_on"] = false
