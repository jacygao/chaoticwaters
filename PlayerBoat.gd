extends KinematicBody2D

const ready = 0
const reloading = 1

 # How fast the player will move (pixels/sec).
export var speed = 200
# Default to 10. Boat sinks when durability reaches 0.
export var durability = 10
# How far can cannon balls reach when shooting.
export var fire_blind_range = 150
# How fast cannons reload.
export var fire_rate = 2
# How much damage do cannon balls cause.
export var fire_damage = 1

# State of the cannon.
var fire_state = reloading
# Size of the game window.
var screen_size
# Add this variable to hold the clicked position.
var target = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = $Camera2D.position
	target = $Camera2D.position
	
# Change the target whenever a touch event happens.
func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		target = get_global_mouse_position()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if durability == 0:
		print("player boat has sunk")
	
	var velocity = Vector2()  # The player's movement vector.
	
	if position.distance_to(target) > 5:
		velocity = target - position

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	move_and_collide(velocity * delta)

	if velocity.x != 0:
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment
		$AnimatedSprite.flip_h = velocity.x > 0
	
	if $ShootRaySouth.is_colliding():
		if $ShootRaySouth.get_collision_point().y - position.y > fire_blind_range:
			if $ShootRaySouth.get_collider().get_class() == "KinematicBody2D":
				fire($ShootRaySouth.get_collider())
			
	if $ShootRayNorth.is_colliding():
		if position.y - $ShootRayNorth.get_collision_point().y > fire_blind_range:
			if $ShootRayNorth.get_collider().get_class() == "KinematicBody2D":
				fire($ShootRayNorth.get_collider())

# Fires cannon balls
func fire(vec):
	if fire_state == ready:
		vec.call("hit", fire_damage)
		fire_state = reloading
		$FireReloadTimer.start()
		
func _on_FireReloadTimer_timeout():
	print("cannon reloaded")
	fire_state = ready
	$FireReloadTimer.stop()
