extends KinematicBody2D

export var team = 1

export var id = "player_boat_1"

export (String) var boat_sprite_path = "res://scenes/Boat/Sprites/PlainBoat.tres"

# navigation speed
export var default_speed = 100
var speed = default_speed

# acceleration speed
export (float) var default_acceleration = 1
var acceleration = default_acceleration

# turnning speed
export (float) var default_rotation_speed = 1
var rotation_speed = default_rotation_speed

# default health
export var max_durability = 10
var durability = 0

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

# v2
var target_node = null

enum {IDLE, MOVING, ATTACKING, ATTACKED, BATTLING, SINKING, FLEEING}
var player_state = IDLE

signal is_sinking
signal battle_victory(node)

# Called when the node enters the scene tree for thes first time.
func _ready():
	$CannonGunRight.rotation_degrees = -90
	$CannonGunLeft.rotation_degrees = 90
	$AnimatedBoatSprite.set_sprite_frames(load(boat_sprite_path))
	
	durability = max_durability
	
# Meta Getters
func type():
	return "ship"
	
func id():
	return id

func team():
	return team

func state():
	return player_state

func set_state(s):
	player_state = s

func set_state_idle():
	anchor_on()
	set_state(IDLE)

func set_state_attacked():
	set_state(ATTACKED)

func set_state_attacking(target):
	set_state(ATTACKING)
	target_node = target
	
func set_state_battling(node):
	set_state(BATTLING)
	target_node = node
	print("battle has started")
	
func set_state_sinking():
	set_state(SINKING)
	
func set_default_state():
	set_state_idle()
	
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
	if player_state == SINKING:
		return
	if durability == 0:
		print("player boat has sunk")
		sink()
		# TODO: player boat has sunk.. what now?

	angle = angle_tidy(rad2deg(cur_rotation))
	health_bar_animate()
	animate(angle)
	$AnimatedBoatSprite.play()
		
func _physics_process(delta):
	match player_state:
		IDLE:
			pass
		MOVING:
			move_animate(delta)
		ATTACKING:
			attack_animate(delta)
		BATTLING:
			speed = default_speed * .1
			battle_animate(delta)
		SINKING:
			pass
			
# Controls ship movement animation
func animate(ta):
	$AnimatedBoatSprite.scale = Vector2(1, 1)
	rotation_degrees = ta - 90

func move_animate(delta):
	pass

func attack_animate(delta):
	move_and_rotate_animate(delta)

# Activates when boat is in battle
func battle_animate(delta):
	if target_node.state() == SINKING:
		set_state(IDLE)
		emit_signal("battle_victory", target_node)
	else:
		move_and_rotate_animate(delta)

func move_and_rotate_animate(delta):
	if cur_rotation > 2*PI:
		cur_rotation-=2*PI
	if cur_rotation < -2*PI:
		cur_rotation+=2*PI
	velocity = Vector2(speed, 0).rotated(cur_rotation)
	var targetPos = target_node.get_global_position()
	
	var target_direction = targetPos - get_global_position()
	var target_angle = rad2deg(target_direction.angle_to(velocity))
	if player_state == BATTLING:
		target_angle+=90
	
	var rotate_velocity = 1
	if abs(target_angle) < 1:
		rotate_velocity = abs(target_angle)
	if target_angle < 0:
		rotation_dir = rotate_velocity
	elif target_angle > 0:
		rotation_dir = -1 * rotate_velocity
	cur_rotation += rotation_dir * rotation_speed * delta
	move_and_slide(velocity)

func health_bar_animate():
	$AnimatedBoatSprite.animation = "hp_green"
	if durability < max_durability * 0.7:
		$AnimatedBoatSprite.animation = "hp_yellow"
	if durability < max_durability * 0.35:
		$AnimatedBoatSprite.animation = "hp_red"
	if durability <= 0:
		$AnimatedBoatSprite.animation = "hp_0"
		
func fire_animate_left():
	if player_state == BATTLING:
		fire_animate($CannonGunLeft/CannonGunAngle)
		
func fire_animate_right():
	if player_state == BATTLING:
		fire_animate($CannonGunRight/CannonGunAngle)
	
# Fires an animated cannon ball at a given vector position
func fire_animate(gun):
	var cannon_ball_ins = cannon_ball.instance()
	var angle = (target_node.get_global_position() - get_global_position()).angle()
	cannon_ball_ins.position = gun.get_global_position()
	cannon_ball_ins.init(angle, fire_damage, fire_max_range)
	gun.get_node("CannonGunFireSmoke").set_emitting(true)
	get_parent().get_parent().add_child(cannon_ball_ins)
	
func hit(damage):
	durability -= damage
	$Fire.set_emitting(true)
	$HealthDisplay.update_healthbar(durability)
	print("Player boat is hit, current durability: ", durability)

func sink():
	speed = 0
	rotation_speed = 0
	set_state_sinking()
	emit_signal("is_sinking")
	
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

func _on_CollisionDetector_body_entered(body):
	if body.has_method("id") && body.id() != id():
		if body.has_method("type") && body.type() == "ship":
			if state() == ATTACKING || state() == ATTACKED:
				# battle starts
				set_state_battling(body)

func _on_CannonGunLeft_fire(target):
	fire_animate_right()

func _on_CannonGunRight_fire(target):
	fire_animate_left()
