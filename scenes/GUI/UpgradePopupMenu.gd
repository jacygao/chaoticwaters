extends Panel

signal fire_upgrade_pressed(cost)
signal armor_upgrade_pressed(cost)
signal speed_upgrade_pressed(cost)
signal close_pressed

export var fire_upgrade_cost = 200
export var armor_upgrade_cost = 50
export var speed_upgrade_cost = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	$FireUpgrade/PriceTag.text = String(fire_upgrade_cost)
	$ArmorUpgrade/PriceTag.text = String(armor_upgrade_cost)
	$SpeedUpgrade/PriceTag.text = String(speed_upgrade_cost)

func _on_FireUpgrade_button_pressed():
	emit_signal("fire_upgrade_pressed", fire_upgrade_cost)

func _on_ArmorUpgrade_button_pressed():
	emit_signal("armor_upgrade_pressed", armor_upgrade_cost)

func _on_SpeedUpgrade_button_pressed():
	emit_signal("speed_upgrade_pressed", speed_upgrade_cost)

func _on_CloseButton_button_pressed():
	emit_signal("close_pressed")
