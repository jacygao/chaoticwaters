extends Panel

signal depart
signal leave

func _on_DepartButton_pressed():
	emit_signal("depart")

func _on_LeaveButton_pressed():
	emit_signal("leave")
