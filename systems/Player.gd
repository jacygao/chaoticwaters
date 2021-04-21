extends Node

"""
	The root of the save system storing top level player data.
	
	tutorial_on - when set to true helpers appear on the screen.
	occupation - the rate player occupies every city in key-value format.
	
"""

var player = {
	"tutorial_on": true,
	"occupation": {},
}

func set_tutorial_off():
	player["tutorial_on"] = false

func occupy(city, rate):
	if player["occupation"].has(city):
		player["occupation"] += rate
	else:
		player["occupation"] = rate
