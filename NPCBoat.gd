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
		# TODO: sink ship
		print("NPC boat has sunk")
		queue_free()
func hit(damage):
	durability -= damage
	print("NPC boat is hit, current durability: ", durability)
