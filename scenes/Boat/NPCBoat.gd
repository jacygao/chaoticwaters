extends KinematicBody2D

export var team = 2
 # How fast the player will move (pixels/sec).
export var speed = 50

var rotation_speed = 1
var cur_rotation = 0
var rotation_dir = 0
var velocity = Vector2()

# Default to 10. Boat sinks when durability reaches 0.
export var max_durability = 10
var durability = max_durability

export var fire_damage = 1

export var fire_max_range = 400

export var is_target_seen = false

var object_type = "ship"

var smoke = preload("res://scenes/Boat/Smoke.tscn")
var cannon_ball = preload("res://scenes/CannonBall/CannonBall.tscn")

signal sinking

# Called when the node enters the scene tree for the first time.
func _ready():
	$CannonGunLeft.rotation_degrees = 0
	$CannonGunRight.rotation_degrees = 180
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if durability <= 0:
		if object_type == "ship":
			sink()

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
	
	var targetPos = get_parent().get_node("PlayerBoat").position
	
	var target_direction = targetPos - position
	var target_angle = rad2deg(target_direction.angle_to(velocity))
	if is_target_seen:
		target_angle = target_angle + 90
	
	var rotate_velocity = 1
	if abs(target_angle) < 1:
		rotate_velocity = abs(target_angle)
	if target_angle < 0:
		rotation_dir = rotate_velocity
	elif target_angle > 0:
		rotation_dir = -1 * rotate_velocity
	cur_rotation += rotation_dir * rotation_speed * delta
	move_and_slide(velocity)
	
func type():
	return object_type

func id():
	return "npc_boat_1"
	
func team():
	return team
	
func hit(damage):
	durability -= damage
	if durability > 0:
		$Fire.set_emitting(true)
	$HealthDisplay.update_healthbar(durability)
	print("NPC boat is hit, current durability: ", durability)

func animate(ta):
	$AnimatedSprite.animation = "hp_green"
	if durability < max_durability * 0.7:
		$AnimatedSprite.animation = "hp_yellow"
	if durability < max_durability * 0.35:
		$AnimatedSprite.animation = "hp_red"
	if durability <= 0:
		$AnimatedSprite.animation = "hp_0"
	$Body.rotation_degrees = ta - 90
	$AnimatedSprite.rotation_degrees = ta - 90

# Fires an animated cannon ball at a given vector position
func fire_animate(vec):
	var cannon_ball_ins = cannon_ball.instance()
	var angle = (vec.position - position).angle()
	$CannonGunAngle.rotation = angle
	cannon_ball_ins.position = $CannonGunAngle/CannonGunPosition.get_global_position()
	cannon_ball_ins.init(angle, fire_damage, fire_max_range)
	$CannonGunAngle/CannonGunFireSmoke.set_emitting(true)
	get_parent().add_child(cannon_ball_ins)
	
func sink():
	$Smoke.set_emitting(true)
	speed = 0
	rotation_speed = 0
	object_type = "wreck"
	emit_signal("sinking")

func _on_CannonGunLeft_fire(target):
	if object_type == "ship":
		fire_animate(target)

func _on_CannonGunRight_fire(target):
	if object_type == "ship" :
		fire_animate(target)

func _on_VisionCircle_body_entered(body):
	if body != self:
		if body.get_class() == "KinematicBody2D":
			is_target_seen = true
			print("target is in range")

func _on_TargetCircle_body_exited(body):
	if body.get_class() == "KinematicBody2D":
		is_target_seen = false
		print("target is out of sight")
