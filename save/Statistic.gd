extends Node

"""
Implementation of a simple Statistic System that stores ship attributes.

Statistics are calculated via a number of factors such as ship level, researches etc.
"""

var statistic = {
	"damage": 1,
	"health": 10,
	"speed": 100,
	"fatigue": 0,
}

func get_all():
	return statistic

func get_damage(stats):
	return stats["damage"]

func get_health(stats):
	return stats["health"]

func get_speed(stats):
	return stats["speed"]

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
		
func reset_fatigue():
	statistic["fatigue"] = 0
