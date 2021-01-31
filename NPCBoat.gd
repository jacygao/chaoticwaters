extends KinematicBody2D

 # How fast the player will move (pixels/sec).
export var speed = 100
# Default to 10. Boat sinks when durability reaches 0.
export var durability = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if durability <= 0:
		# TODO: ship sinking animation
		print("NPC boat has sunk")
		queue_free()
	
	var velocity = Vector2()  # The player's movement vector.
	
	var targetPos = get_parent().get_node("PlayerBoat").position
	
	if position.distance_to(targetPos) > 5:
		velocity = targetPos - position

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
	$ParticleFire.set_emitting(true)
	print("NPC boat is hit, current durability: ", durability)

func animate(ta):
	$AnimatedSprite.scale = Vector2(2, 2)
	$Body.rotation_degrees = 0
	$Body.position.x = 0
	$Body.position.y = 0
	$ParticleFire.position.x = -5
	$ParticleFire.position.y = 60
	if ta >= -45 && ta <= 45:
		$Body.rotation_degrees = 90
		$AnimatedSprite.animation = "right"
		$Body.position.x = -10
		$Body.position.y = 60
	elif ta > 45 && ta < 135:
		$AnimatedSprite.animation = "down"
		$ParticleFire.position.y = 10
	elif ta < -45 && ta > -135:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.scale = Vector2(1.8, 1.8)
		$Body.position.y = 20
		$ParticleFire.position.y = 10
	else:
		$AnimatedSprite.animation = "left"
		$Body.rotation_degrees = 90
		$Body.position.x = 10
		$Body.position.y = 60
