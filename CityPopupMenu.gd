extends Panel

signal fire_upgrade_pressed
signal armor_upgrade_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_FireUpgrade_button_pressed():
	emit_signal("fire_upgrade_pressed")


func _on_ArmorUpgrade_button_pressed():
	emit_signal("armor_upgrade_pressed")