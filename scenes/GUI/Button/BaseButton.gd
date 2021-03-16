extends TextureButton

onready var time_label = $Counter/Value

export var cooldown = 2.0
export var counter_text = ""
export var texture_path = "res://assets/icons/click.png"
export var desciption = ""
export var show_desc = true
export var cost = 100
export var level = 0

signal button_pressed

func _ready():
	self.texture_normal = load(texture_path)
	$LabelPanel/Tooltip.text = desciption
	$Timer.wait_time = cooldown
	time_label.hide()
	if cooldown > 0:
		$Sweep.texture_progress = texture_normal
		$Sweep.value = 0
	else: 
		$Sweep.hide()
		$Counter.hide()
	$LabelPanel.visible = false
	if show_desc:
		$LabelPanel.visible = true
	set_process(false)

func _process(_delta):
	time_label.text = "%3.1f" % $Timer.time_left
	if cooldown > 0:
		$Sweep.value = int(($Timer.time_left / cooldown) * 100)

func set_cooldown(value):
	cooldown = value

func _on_FireButton_pressed():
	disabled = true
	emit_signal("button_pressed")
	set_process(true)
	$Timer.start()
	time_label.show()

func _on_Timer_timeout():
	$Sweep.value = 0
	disabled = false
	time_label.hide()
	set_process(false)
