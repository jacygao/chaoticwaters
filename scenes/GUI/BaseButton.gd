extends TextureButton

onready var time_label = $Counter/Value

export var cooldown = 2.0
export var counter_text = ""
export var texture_path = "res://assets/icons/cannon_shot.png"
export var desciption = ""

signal cannon_fired

func _ready():
	self.texture_normal = load(texture_path)
	self.hint_tooltip = desciption
	$Timer.wait_time = cooldown
	time_label.hide()
	$Sweep.texture_progress = texture_normal
	$Sweep.value = 0
	set_process(false)

func _process(delta):
	time_label.text = "%3.1f" % $Timer.time_left
	$Sweep.value = int(($Timer.time_left / cooldown) * 100)

func set_cooldown(value):
	cooldown = value

func _on_FireButton_pressed():
	disabled = true
	emit_signal("cannon_fired")
	set_process(true)
	$Timer.start()
	time_label.show()


func _on_Timer_timeout():
	print("ability ready")
	$Sweep.value = 0
	disabled = false
	time_label.hide()
	set_process(false)
