extends KinematicBody2D

 # How fast the player will move (pixels/sec).
export var speed = 50
# Default to 10. Boat sinks when durability reaches 0.
export var durability = 10

export var fire_damage = 1

export var fire_max_range = 400

var smoke = preload("res://Smoke.tscn")
var cannon_ball = preload("res://scenes/CannonBall/CannonBall.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$CannonGunLeft.rotation_degrees = 0
	$CannonGunRight.rotation_degrees = 180
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if durability <= 0:
		# TODO: ship sinking animation
		sink()
		print("NPC boat has sunk")
		queue_free()
	
	var velocity = Vector2()  # The player's movement vector.
	
	var targetPos = get_parent().get_node("PlayerBoat").position
	
	if position.distance_to(targetPos) > 5:
		velocity = targetPos - position
	var gun_angle = rad2deg(velocity.angle())
	$CannonGunRight.rotation_degrees = gun_angle + 180
	$CannonGunLeft.rotation_degrees = gun_angle
	
	var target_angle = rad2deg(targetPos.angle_to_point(position))
		
	animate(target_angle)
	$AnimatedSprite.play()
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		move_and_collide(velocity * delta)
		
func type():
	return "ship"

func hit(damage):
	durability -= damage
	$Fire.set_emitting(true)
	$HealthDisplay.update_healthbar(durability * 10)
	print("NPC boat is hit, current durability: ", durability)

func animate(ta):
	$AnimatedSprite.scale = Vector2(2, 2)
	$Body.rotation_degrees = 0
	$Body.position.x = 0
	$Body.position.y = 0
	$Fire.position.x = -5
	$Fire.position.y = 60
	if ta >= -45 && ta <= 45:
		$Body.rotation_degrees = 90
		$AnimatedSprite.animation = "right"
		$Body.position.x = -10
		$Body.position.y = 60
	elif ta > 45 && ta < 135:
		$AnimatedSprite.animation = "down"
		$Fire.position.y = 10
	elif ta < -45 && ta > -135:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.scale = Vector2(1.8, 1.8)
		$Body.position.y = 20
		$Fire.position.y = 10
	else:
		$AnimatedSprite.animation = "left"
		$Body.rotation_degrees = 90
		$Body.position.x = 10
		$Body.position.y = 60

# Fires an animated cannon ball at a given vector position
func fire_animate(vec):
	var cannon_ball_ins = cannon_ball.instance()
	$CannonGunAngle.rotation = (vec.position - position).angle()
	cannon_ball_ins.position = $CannonGunAngle/CannonGunPosition.get_global_position()
	cannon_ball_ins.init(vec, fire_damage, fire_max_range)
	get_parent().add_child(cannon_ball_ins)
	
func sink():
	var smoke_animation = smoke.instance()
	smoke_animation.position = position
	smoke_animation.set_emitting(true)
	get_parent().add_child(smoke_animation)


func _on_CannonGunLeft_fire(target):
	fire_animate(target)


func _on_CannonGunRight_fire(target):
	fire_animate(target)
