extends RigidBody2D

export var speed = 400

var fire_rotation = 0

var fire_target = Vector2()

var fire_damage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	gravity_scale = 0
	apply_impulse(Vector2(), Vector2(speed, 0).rotated(fire_rotation))

func init(vec, damage):
	fire_rotation = self.get_angle_to(vec.position)
	fire_target = vec
	fire_damage = damage
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_CannonBall_body_entered(body):
	if body.has_method("type") && body.type() == "ship":
		print(body.type())
		fire_target.call("hit", fire_damage)
	queue_free()
