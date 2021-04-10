extends Node2D

signal attack_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_PlayerBoat_input_event(viewport, event, shape_idx):
	if event.is_action_pressed('ui_touch'):
		$PopupControlPirate.open($Boat.get_global_position())
		get_tree().set_input_as_handled()

func _on_PopupControlPirate_is_attacked():
	emit_signal("attack_pressed")
