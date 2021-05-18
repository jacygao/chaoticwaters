extends Node

var notification = preload("res://scenes/GUI/Notification/Notification.tscn")

enum notification_level {INFO, WARN}

func show_message(node, level, message):
	var notifier = notification.instance()
	node.add_child(notifier)
	notifier.show_message(level, message)
	
func info(node, message):
	show_message(node, notification_level.INFO, message)
	
func warn(node, message):
	show_message(node, notification_level.WARN, message)
