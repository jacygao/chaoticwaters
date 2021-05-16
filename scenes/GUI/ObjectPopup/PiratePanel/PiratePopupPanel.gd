extends Panel

signal attack_button_pressed

func render_title(lvl):
	$Label.text = "Level "+String(lvl)+" Pirate"

func _on_PirateAttackButton_pressed():
	emit_signal("attack_button_pressed")
