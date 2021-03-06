extends Boat

export var team = 2
 # How fast the player will move (pixels/sec)
export var speed = 50
# A target has entered visible range of the NPC boat
export var is_target_seen = false

var object_type = "ship"

signal sinking

# Called when the node enters the scene tree for the first time.
func _ready():
	$CannonGunRight.rotation_degrees = -90
	$CannonGunLeft.rotation_degrees = 90
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if durability <= 0:
		if object_type == "ship":
			sink()

	var angle = angle_tidy(rad2deg(cur_rotation))
	
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
	rotation_degrees = ta - 90

# Fires an animated cannon ball at a given vector position
func fire_animate(gun):
	var cannon_ball_ins = cannon_ball.instance()
	var pos = gun.get_node("CannonGunPosition").get_global_position()
	cannon_ball_ins.position = pos
	cannon_ball_ins.init((pos-position).angle(), fire_damage, fire_max_range)
	gun.get_node("CannonGunFireSmoke").set_emitting(true)
	get_parent().add_child(cannon_ball_ins)
	
func sink():
	$Smoke.set_emitting(true)
	speed = 0
	rotation_speed = 0
	object_type = "wreck"
	emit_signal("sinking")

func _on_CannonGunLeft_fire(target):
	if object_type == "ship":
		# Why opposite gun fire?
		fire_animate($CannonGunRight/CannonGunAngle)

func _on_CannonGunRight_fire(target):
	if object_type == "ship" :
		fire_animate($CannonGunLeft/CannonGunAngle)

func _on_VisionCircle_body_entered(body):
	if body != self:
		if body.get_class() == "KinematicBody2D":
			is_target_seen = true
			print("target is in range")

func _on_TargetCircle_body_exited(body):
	if body.get_class() == "KinematicBody2D":
		is_target_seen = false
		print("target is out of sight")
