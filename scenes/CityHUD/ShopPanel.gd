extends Panel

signal trade
signal invest
signal leave

func _on_TradeButton_pressed():
	emit_signal("trade")

func _on_InvestButton_pressed():
	emit_signal("invest")

func _on_LeaveButton_pressed():
	emit_signal("leave")
