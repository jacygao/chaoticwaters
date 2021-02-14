extends Position2D


# Declare member variables here. Examples:
export var default_cannon_gun_position = float(80)


# Called when the node enters the scene tree for the first time.
func _ready():
	$CannonGunPosition.transform.x = Vector2(default_cannon_gun_position, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
