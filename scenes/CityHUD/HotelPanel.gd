extends Panel

signal one_night
signal recover_all
signal leave

func _on_OneNightButton_pressed():
	emit_signal("one_night")

func _on_RecoverAllButton_pressed():
	emit_signal("recover_all")

func _on_LeaveButton_pressed():
	emit_signal("leave")

