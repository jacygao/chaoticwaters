extends KinematicBody2D

const ready = 0
const reloading = 1

 # How fast the player will move (pixels/sec).
export var speed = 200
# Default to 10. Boat sinks when durability reaches 0.
export var durability = 10
# How far can cannon balls reach when shooting.
export var fire_blind_range = 100
# How fast cannons reload.
export var fire_rate = 2
# How much damage do cannon balls cause.
export var fire_damage = 1

# State of the cannon.
var fire_state = reloading

var nav_direction

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
		# TODO: player boat has sunk.. what now?
		
	var velocity = Vector2()  # The player's movement vector.
	
	if position.distance_to(target) > 5:
		velocity = target - position

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()

	move_and_collide(velocity * delta)

	var y_dis = abs(target.y - position.y)
	var x_dis = abs(target.x - position.x)

	if x_dis >= y_dis:
		$AnimatedSprite.scale = Vector2(1.3, 1.3)
		$Body.rotation_degrees = 90
		$Body.position.y = 30
		$ShootRayNorth.rotation_degrees = 0
		$ShootRaySouth.rotation_degrees = 180
		$ParticleShoot.position.y = 45
		if velocity.x > 0:
			$Body.position.x = -10
			$ParticleShoot.position.x = -30
			$AnimatedSprite.animation = "right"
		elif velocity.x < 0:
			$Body.position.x = -20
			$ParticleShoot.position.x = 0
			$AnimatedSprite.animation = "left"
	else:
		$AnimatedSprite.scale = Vector2(1, 1)
		$Body.rotation_degrees = 0
		$Body.position.x = 0
		$Body.position.y = 0
		$ShootRayNorth.rotation_degrees = 90
		$ShootRaySouth.rotation_degrees = 270
		if velocity.y > 0:
			$AnimatedSprite.animation = "down"
		if velocity.y < 0:
			$AnimatedSprite.animation = "up"
		
	if $ShootRaySouth.is_colliding():
		var south_collider = $ShootRaySouth.get_collider()
		if south_collider.get_class() == "KinematicBody2D":
			if is_in_range(south_collider):
				fire(south_collider)
			
	if $ShootRayNorth.is_colliding():
		var north_collider = $ShootRayNorth.get_collider()
		if north_collider.get_class() == "KinematicBody2D":
			if is_in_range(north_collider):
					fire(north_collider)

# Fires cannon balls
func fire(vec):
	if fire_state == ready:
		$ParticleShoot.set_emitting(true)
		vec.call("hit", fire_damage)
		fire_state = reloading
		$FireReloadTimer.start()
		
func _on_FireReloadTimer_timeout():
	print("cannon reloaded")
	fire_state = ready
	$FireReloadTimer.stop()

func is_in_range(enemy):
	if abs(enemy.position.y - position.y) > fire_blind_range || abs(enemy.position.x - position.x) > fire_blind_range:
		return true
	else:
		return false
