extends Node

"""
	The root of the save system storing top level player data.
	
	tutorial_on - when set to true helpers appear on the screen.
	occupation - the rate player occupies every city in key-value format.
	
"""

var player = {
	"name": "Laurien Plesger",
	"tutorial_on": true,
	"occupation": {},
	"coordinate": Vector2(),
	"docking": "",
}

func set_tutorial_off():
	player["tutorial_on"] = false

func occupy(city, rate):
	if !player["occupation"].has(city):
		player["occupation"][city] = 0
	player["occupation"][city] += rate

func get_city_occupation(city):
	if !player["occupation"].has(city):
		return 0
	return player["occupation"][city]

func get_name():
	return player["name"]

func set_coordinate(c:Vector2):
	player["coordinate"] = c

func get_coordinate():
	return player["coordinate"]

func set_docking_city(city:String):
	player["docking"] = city

func get_docking_city():
	return player["docking"]
