extends Node2D

signal attack_pressed(node)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_PlayerBoat_input_event(viewport, event, shape_idx):
	if $Boat.state() == $Boat.SINKING:
		return
	if event.is_action_pressed('ui_touch'):
		# display popup in the most appropriate position.
		# if popup width is greater that the object position to the edge of viewport,
		# render popup on the mirror side of its Y axis.
		print($Boat.get_global_transform_with_canvas().get_origin().x)
		print(get_viewport().size.x)
		if get_viewport().size.x - $Boat.get_global_transform_with_canvas().get_origin().x >= $PopupControlPirate.get_popup_size().x:
			$PopupControlPirate.open($Boat.get_global_position())
		else:
			var pos = $Boat.get_global_position()
			pos.x -= $PopupControlPirate.get_popup_size().x
			$PopupControlPirate.open(pos)
			
		get_tree().set_input_as_handled()
			
func _on_PopupControlPirate_is_attacked():
	$Boat.set_state_attacked()
	emit_signal("attack_pressed", $Boat)

func _on_Boat_is_sinking():
	print("starting timer")
	$SinkTimer.start()

func _on_SinkTimer_timeout():
	print("time out triggered")
	queue_free()
