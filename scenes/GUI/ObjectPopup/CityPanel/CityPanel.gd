extends Panel

signal enter_pressed

func _on_ObjectPopupButton_pressed():
	emit_signal("enter_pressed")
