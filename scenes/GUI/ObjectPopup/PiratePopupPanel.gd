extends Panel

signal attack_button_pressed

func _on_PirateAttackButton_pressed():
	emit_signal("attack_button_pressed")
