extends KinematicBody2D

 # How fast the player will move (pixels/sec).
export var speed = 200
export (float) var rotation_speed = 2
var cur_rotation = 0
var rotation_dir = 0
var velocity = Vector2()

# Default to 10. Boat sinks when durability reaches 0.
export var durability = 10

# Setting cannon gun related attributes.
# These values are now in the CannonGun nodes as well but 
# they will still need to be set in order to customise
export var fire_blind_range = 100
export var fire_max_range = 300
export var fire_rate = 2
export var fire_damage = 1

var target_direction = Vector2()
var target_rotation = 0

# Size of the game window.
var screen_size
# Add this variable to hold the clicked position.
var target = Vector2()

var rotating = false
var last_x = 0

var cannon_ball = preload("res://CannonBall.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = $Camera2D.position
	target = $Camera2D.position
	$AnimatedSprite.modulate.a
	$CannonBall/Body
	
func type():
	return "ship"
	
# Change the target whenever a touch event happens.
func _input(event):
	rotation_dir = 0
	if event is InputEventScreenTouch and event.pressed:
		target = get_global_mouse_position()
		target_direction = target - position
		target_rotation = target_direction.angle()
		print(rad2deg(target_rotation))
	if event.is_action_pressed('ui_right'):
		rotation_dir += 1
	if event.is_action_pressed('ui_left'):
		rotation_dir -= 1
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if durability == 0:
		print("player boat has sunk")
		# TODO: player boat has sunk.. what now?
	var angle = rad2deg(cur_rotation)
	if angle > 180:
		angle = (360 - angle) * -1
	if angle < -180:
		angle = 360 - angle * -1
	animate(angle)
	$AnimatedSprite.play()
	
	$CannonGunRight.rotation_degrees = angle + 180
	$CannonGunLeft.rotation_degrees = angle
		
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
	$AnimatedSprite.scale = Vector2(1.3, 1.3)
	$Body.rotation_degrees = 0
	$Body.position.x = 0
	$Body.position.y = 0
	if ta >= -45 && ta <= 45:
		$Body.rotation_degrees = 90
		$AnimatedSprite.animation = "right"
		$Cannon.position.x = -20
		$Body.position.x = -30
		$Body.position.y = 20
	elif ta > 45 && ta < 135:
		$AnimatedSprite.animation = "down"
		$AnimatedSprite.scale = Vector2(1, 1)
	elif ta < -45 && ta > -135:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.scale = Vector2(1, 1)
		$Body.position.y = 20
	else:
		$AnimatedSprite.animation = "left"
		$Body.rotation_degrees = 90
		$Body.position.y = 20
		$Cannon.position.y = 30
		
# Fires an animated cannon ball at enermy		
func fire_animate(vec):
	var cannon_ball_ins = cannon_ball.instance()
	$GunAngle.rotation = (vec.position - position).angle()
	cannon_ball_ins.position = $GunAngle/GunPos.get_global_position()
	cannon_ball_ins.init(vec, fire_damage, fire_max_range)
	get_parent().add_child(cannon_ball_ins)

func hit(damage):
	durability -= damage
	print("Player boat is hit, current durability: ", durability)

func _on_CannonGunLeft_fire(vec):
	fire_animate(vec)


func _on_CannonGunRight_fire(vec):
	fire_animate(vec)
