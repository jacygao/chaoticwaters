extends Control

signal attack_pirate_pressed

func _on_PirateAttackButton_pressed():
	emit_signal("attack_pirate_pressed")
