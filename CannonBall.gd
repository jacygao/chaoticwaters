extends RigidBody2D

export var speed = 400

var fire_rotation = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	gravity_scale = 0
	apply_impulse(Vector2(), Vector2(speed, 0).rotated(fire_rotation))

func init(r):
	fire_rotation = r

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
