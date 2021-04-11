extends Node

# Size of the game window.
var screen_size

signal enter_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = $Boat/Camera2D.position
			
func anchor_on():
	$Boat.anchor_on()

func anchor_off():
	$Boat.anchor_off()

func _on_PopupControlPlayer_enter_pressed():
	emit_signal("enter_pressed")

func _on_Boat_input_event(viewport, event, shape_idx):
	if event.is_action_pressed('ui_touch'):
		#$PopupControlPlayer.set_global_transform($Boat.get_global_transform_with_canvas())
		$PopupControlPlayer.open($Boat.get_global_position())
		get_tree().set_input_as_handled()

# player boat is attacking an enemy boat
func attacking(node):
	$Boat.set_state_attacking(node)
