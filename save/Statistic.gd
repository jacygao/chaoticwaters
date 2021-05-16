extends Node

"""
Implementation of a simple Statistic System that stores ship attributes.

Statistics are calculated via a number of factors such as ship level, researches etc.
"""

var statistic = {
	"damage": 1,
	"max_health": 10,
	"health": 10,
	"speed": 200,
	"fatigue": 0,
}

func get_all():
	return statistic

func get_damage():
	return statistic["damage"]

func get_health():
	return statistic["health"]

func get_max_health():
	return statistic["max_health"]
	
func subtract_health(v):
	if statistic["health"] < v:
		statistic["health"] = 0
	else:
		statistic["health"] = statistic["health"] - v

func reset_health():
	statistic["health"] = statistic["max_health"]
		
func get_speed():
	return statistic["speed"]

func get_fatigue(stats):
	return stats["fatigue"]

func set_fatigue(v):
	if v > 100:
		v = 100
	statistic["fatigue"] = v

func add_fatigue(v):
	statistic["fatigue"] = statistic["fatigue"] + v
	if statistic["fatigue"] > 100:
		statistic["fatigue"] = 100

func subtract_fatigue(v):
	if statistic["fatigue"] < v:
		statistic["fatigue"] = 0
	else:
		statistic["fatigue"] = statistic["fatigue"] - v

func reset_fatigue():
	statistic["fatigue"] = 0
