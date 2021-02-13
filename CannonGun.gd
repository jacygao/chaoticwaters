extends RayCast2D

# Declare constants for the current node.
const ready = 0
const reloading = 1

# Declare member variables here. Examples:
export var fire_range = 400
export var fire_damage = 1
export var fire_blind_range = 100
export var fire_interval = 2
var fire_state = ready

signal fire(target)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Reloading.wait_time = fire_interval

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		var collider = get_collider()
		if collider != null && collider.get_class() == "KinematicBody2D":
			if is_in_range(collider):
				print("colliding detected")
				fire(collider)

func is_in_range(collider):
	if abs(collider.position.y - position.y) > fire_blind_range || abs(collider.position.x - position.x) > fire_blind_range:
		return true
	else:
		return false

# Fires cannon balls
func fire(collider):
	if fire_state == ready:
		emit_signal("fire", collider)
		fire_state = reloading
		$Reloading.start()


func _on_Reloading_timeout():
	print("cannon reloaded")
	fire_state = ready
	$Reloading.stop()
