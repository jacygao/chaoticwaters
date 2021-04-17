extends Panel

signal enter_button_pressed

func _on_PlayerEnterButton_pressed():
	emit_signal("enter_button_pressed")
