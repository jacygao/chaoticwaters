extends Panel

export var damage = 1
export var health = 10
export var speed = 100
export var fatigue = 0

var stats = {}

func _ready():
	stats = Statistic.get_all()
	update_text()

func _process(delta):
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

func set_fatigue(v):
	fatigue = v
	$Fatigue.set_text(fatigue)

func update_text():
	$Damage.set_text(Statistic.get_damage(stats))
	$Health.set_text(Statistic.get_health(stats))
	$Speed.set_text(Statistic.get_speed(stats))
	$Fatigue.set_text(Statistic.get_fatigue(stats))
