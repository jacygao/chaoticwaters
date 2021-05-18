extends Panel

enum {INFO, WARN}

func show_message(level, message):
	var color = Color(0, 0, 0, 1)
	match level:
		INFO:
			color = Color(0, 1, 0, 1)
		WARN:
			color = Color(1, .19, .19, 1)
			
	$Message.text = message
	$Message.self_modulate = color
	$Message.visible = true
	$MessagePanelTimer.start()

func _on_MessagePanelTimer_timeout():
	$MessagePanelTimer.stop()
	queue_free()
