extends Panel

signal upgrade_button_pressed
signal research_button_pressed

func _on_UpgradeButton_button_pressed():
	emit_signal("upgrade_button_pressed")

func _on_ResearchButton_button_pressed():
	emit_signal("research_button_pressed")
