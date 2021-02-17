extends KinematicBody2D

 # How fast the player will move (pixels/sec).
export var speed = 50
# Default to 10. Boat sinks when durability reaches 0.
export var durability = 10
export var max_durability = 10

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
	$AnimatedSprite.animation = "hp_green"
	if durability < max_durability * 0.7:
		$AnimatedSprite.animation = "hp_yellow"
	if durability < max_durability * 0.35:
		$AnimatedSprite.animation = "hp_red"
	$Body.rotation_degrees = ta - 90
	$AnimatedSprite.rotation_degrees = ta - 90

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
