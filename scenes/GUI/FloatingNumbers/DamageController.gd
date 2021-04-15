extends Node2D

var FloatingNumbers = preload("res://scenes/GUI/FloatingNumbers/FloatingNumbers.tscn")

export var travel = Vector2(0, -80)
export var duration = 2
export var spread = PI/2

func show_value(value, crit=false):
	var fn = FloatingNumbers.instance()
	add_child(fn)
	fn.show_value(str(value), travel, duration, spread, crit)
