extends Node


# Declare member variables here. Examples:
export var fire_rate = 2.0
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD/FireButtonRight.call("set_cooldown", fire_rate)
	$HUD/FireButtonLeft.call("set_cooldown", fire_rate)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_FireButtonLeft_cannon_fired():
	$PlayerBoat.call("fire_animate_left")


func _on_FireButtonRight_cannon_fired():
	$PlayerBoat.call("fire_animate_right")
