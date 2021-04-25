extends Panel

signal repair
signal alter
signal leave

func _on_LeaveButton_pressed():
	emit_signal("leave")

func _on_AlterButton_pressed():
	emit_signal("alter")

func _on_RepairButton_pressed():
	emit_signal("repair")
