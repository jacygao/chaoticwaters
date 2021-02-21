extends KinematicBody2D

 # How fast the player will move (pixels/sec).
export var default_speed = 100
var speed = default_speed

export (float) var default_rotation_speed = 1
var rotation_speed = default_rotation_speed

var cur_rotation = 0
var rotation_dir = 0
var velocity = Vector2()

# Default to 10. Boat sinks when durability reaches 0.
export var durability = 10
export var max_durability = 10

# Setting cannon gun related attributes.
# These values are now in the CannonGun nodes as well but 
# they will still need to be set in order to customise
export var fire_blind_range = 100
export var fire_max_range = 300
export var fire_rate = 2.0
export var fire_damage = 1

var target_direction = Vector2()
var target_rotation = 0

# Size of the game window.
var screen_size
# Add this variable to hold the clicked position.
var target = Vector2()

var rotating = false
var last_x = 0

var cannon_ball = preload("res://scenes/CannonBall/CannonBall.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = $Camera2D.position
	target = $Camera2D.position
	
func type():
	return "ship"
	
func _unhandled_input(event):
	if event.is_action_pressed('ui_touch'):
		target = get_global_mouse_position()
		target_direction = target - position
		
# Change the target whenever a touch event happens.
func _input(event):
	rotation_dir = 0
	if event.is_action_pressed('ui_right'):
		rotation_dir += 1
	if event.is_action_pressed('ui_left'):
		rotation_dir -= 1
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if durability == 0:
		print("player boat has sunk")
		# TODO: player boat has sunk.. what now?
	var angle = rad2deg(cur_rotation)
	if angle > 180:
		angle = (360 - angle) * -1
	if angle < -180:
		angle = 360 - angle * -1
	
	$CannonGunRight.rotation_degrees = angle + 180
	$CannonGunLeft.rotation_degrees = angle
	
	animate(angle)
	$AnimatedSprite.play()
		
func _physics_process(delta):
	if cur_rotation > 2*PI:
		cur_rotation-=2*PI
	if cur_rotation < -2*PI:
		cur_rotation+=2*PI
	velocity = Vector2(speed, 0).rotated(cur_rotation)
	
	var target_angle = target_direction.angle_to(velocity)
	var rotate_velocity = 1
	if abs(target_angle) < 1:
		rotate_velocity = abs(target_angle)
	if target_angle < 0:
		rotation_dir = rotate_velocity
	elif target_angle > 0:
		rotation_dir = -1 * rotate_velocity
	
	cur_rotation += rotation_dir * rotation_speed * delta
	move_and_slide(velocity)

# Controls ship movement animation
func animate(ta):
	$AnimatedSprite.animation = "hp_green"
	if durability < max_durability * 0.7:
		$AnimatedSprite.animation = "hp_yellow"
	elif durability < max_durability * 0.35:
		$AnimatedSprite.animation = "hp_red"
		
	$AnimatedSprite.scale = Vector2(1, 1)
	$Body.rotation_degrees = ta - 90
	$AnimatedSprite.rotation_degrees = ta - 90
	$Body.position.x = 0
	$Body.position.y = 0
		
func fire_animate_left():
	fire_animate(velocity.rotated(deg2rad(-90)))
		
func fire_animate_right():
	fire_animate(velocity.rotated(deg2rad(90)))
	
# Fires an animated cannon ball at a given vector position
func fire_animate(vec):
	var cannon_ball_ins = cannon_ball.instance()
	$CannonGunAngle.rotation = vec.angle()
	cannon_ball_ins.position = $CannonGunAngle/CannonGunPosition.get_global_position()
	cannon_ball_ins.init(vec, fire_damage, fire_max_range)
	$CannonGunAngle/CannonGunFireSmoke.set_emitting(true)
	get_parent().add_child(cannon_ball_ins)

func anchor_on():
	speed = 0
	rotation_speed = 0

func anchor_off():
	speed = default_speed
	rotation_speed = default_rotation_speed

func hit(damage):
	durability -= damage
	$Fire.set_emitting(true)
	$HealthDisplay.update_healthbar(durability * 10)
	print("Player boat is hit, current durability: ", durability)

func sink():
	pass
