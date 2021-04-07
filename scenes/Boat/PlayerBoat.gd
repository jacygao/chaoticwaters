extends KinematicBody2D

export var team = 1

export var id = "player_boat_1"

# navigation speed
export var default_speed = 50
var speed = default_speed

# acceleration speed
export (float) var default_acceleration = 1
var acceleration = default_acceleration

# turnning speed
export (float) var default_rotation_speed = 1
var rotation_speed = default_rotation_speed

# default health
export var max_durability = 10
var durability = max_durability

# Setting cannon gun related attributes.
# These values are now in the CannonGun nodes as well but 
# they will still need to be set in order to customise
export var fire_damage = 1
export var fire_max_range = 300
export var fire_blind_range = 100
export var fire_rate = 2.0

# speed sets to 0 when true
var isAnchorOn = false

var static_velocity = Vector2()
var angle = 0

# navigation control variables
var cur_rotation = 0
var rotation_dir = 0
var velocity = Vector2()

var target_direction = Vector2()
var target_rotation = 0

var rotating = false
var last_x = 0

var smoke = preload("res://scenes/Boat/Smoke.tscn")
var cannon_ball = preload("res://scenes/CannonBall/CannonBall.tscn")

signal is_sinking

# Called when the node enters the scene tree for the first time.
func _ready():
	$CannonGunRight.rotation_degrees = -90
	$CannonGunLeft.rotation_degrees = 90
	
# Meta Getters
func type():
	return "ship"
	
func id():
	return id

func team():
	return team

func set_target(val):
	target_direction = val - position

# ensures the angle is netween -179 and 180 degrees
func angle_tidy(a):
	if a > 180:
		a = (360 - a) * -1
	if a < -180:
		a = 360 - a * -1
	return a

func anchor_on():
	speed = 0
	rotation_speed = 0
	isAnchorOn = true
	
func anchor_off():
	rotation_speed = default_rotation_speed
	isAnchorOn = false

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
		sink()
		# TODO: player boat has sunk.. what now?

	angle = angle_tidy(rad2deg(cur_rotation))
	animate_health_bar()
	animate(angle)
	$AnimatedSprite.play()
		
func _physics_process(delta):
	if !isAnchorOn:
		if speed < default_speed:
			speed += acceleration
		if speed > default_speed:
			speed = default_speed
		
	velocity = Vector2(speed, 0).rotated(cur_rotation)
	if speed > 0:
		static_velocity = velocity
	
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
	$AnimatedSprite.scale = Vector2(1, 1)
	rotation_degrees = ta - 90
		
func animate_health_bar():
	$AnimatedSprite.animation = "hp_green"
	if durability < max_durability * 0.7:
		$AnimatedSprite.animation = "hp_yellow"
	if durability < max_durability * 0.35:
		$AnimatedSprite.animation = "hp_red"
	if durability <= 0:
		$AnimatedSprite.animation = "hp_0"
		
func fire_animate_left():
	fire_animate($CannonGunLeft/CannonGunAngle)
		
func fire_animate_right():
	fire_animate($CannonGunRight/CannonGunAngle)
	
# Fires an animated cannon ball at a given vector position
func fire_animate(gun):
	var cannon_ball_ins = cannon_ball.instance()
	var pos = gun.get_node("CannonGunPosition").get_global_position()
	cannon_ball_ins.position = pos
	cannon_ball_ins.init((pos-position).angle(), fire_damage, fire_max_range)
	gun.get_node("CannonGunFireSmoke").set_emitting(true)
	get_parent().add_child(cannon_ball_ins)
	
func hit(damage):
	durability -= damage
	$Fire.set_emitting(true)
	$HealthDisplay.update_healthbar(durability)
	print("Player boat is hit, current durability: ", durability)

func sink():
	speed = 0
	rotation_speed = 0

func update_durability():
	$HealthDisplay.update_max_health(max_durability)
	$HealthDisplay.update_healthbar(durability)

func repair():
	if durability < max_durability:
		durability+=1
		update_durability()
	elif durability > max_durability:
		durability = max_durability
		update_durability()

func _unhandled_input(event):
	if event.is_action_pressed('ui_touch'):
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_point( get_global_mouse_position(), 32, [], 1, true, true )
		print(result)
		
func _on_PlayerBoat_input_event(viewport, event, shape_idx):
	print(event)
