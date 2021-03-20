extends Panel

signal close_button_pressed

func _on_CloseButton_button_pressed():
	emit_signal("close_button_pressed")
