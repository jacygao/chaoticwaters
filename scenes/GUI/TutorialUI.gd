extends Node2D

func _ready():
	close()
	
func open():
	visible = true

func close():
	visible = false

func set_pos(pos):
	position = pos
