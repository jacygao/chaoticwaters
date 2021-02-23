extends Node2D

# Declare member variables here. Examples:
export var fire_range = 500
export (float) var default_rotation_speed = 1
var rotation_speed = default_rotation_speed

var cur_rotation

# Called when the node enters the scene tree for the first time.
func _ready():
	$Outpost/FireRange.shape.radius = fire_range
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func type():
	return "city"

func _on_Outpost_body_entered(body):
	print("detected body enterred")


func _on_Outpost_body_exited(body):
	print("body has left")
