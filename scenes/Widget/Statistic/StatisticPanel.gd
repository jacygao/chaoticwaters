extends Panel

export var damage = 1
export var health = 10
export var speed = 100

func _ready():
	update_text()

func set_damage(v):
	damage = v
	$Damage.set_text(damage)

func set_health(v):
	health = v
	$Health.set_text(health)

func set_speed(v):
	speed = v
	$Speed.set_text(speed)

func update_text():
	$Damage.set_text(damage)
	$Health.set_text(health)
	$Speed.set_text(speed)
