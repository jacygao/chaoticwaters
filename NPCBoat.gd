extends KinematicBody2D

 # How fast the player will move (pixels/sec).
export var speed = 200
# Default to 10. Boat sinks when durability reaches 0.
export var durability = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if durability <= 0:
		# TODO: ship sinking animation
		print("NPC boat has sunk")
		queue_free()
	
	#var velocity = Vector2()  # The ship's movement vector.
	$AnimatedSprite.animation = "right"
	$Body.rotation_degrees = 90
	$Body.position.x = -10
	$Body.position.y = 60
	$ParticleFire.position.x = -5
	$ParticleFire.position.y = 60
	$AnimatedSprite.play()
		
func type():
	return "ship"

func hit(damage):
	durability -= damage
	$ParticleFire.set_emitting(true)
	print("NPC boat is hit, current durability: ", durability)
