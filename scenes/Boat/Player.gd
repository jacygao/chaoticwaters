extends Node

# Size of the game window.
var screen_size
# Add this variable to hold the clicked position.
var target = Vector2()

signal enter_pressed

# defining a list of states of player node
enum {IDLE, MOVING, ATTACKING}

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = $Boat/Camera2D.position
	target = $Boat/Camera2D.position

func _unhandled_input(event):
	if event.is_action_pressed('ui_touch'):
		if !$Boat.isAnchorOn:
			target = $Boat.get_global_mouse_position()
			$Boat.set_target(target)
			
func anchor_on():
	$Boat.anchor_on()

func anchor_off():
	$Boat.anchor_off()

func _on_PopupControlPlayer_enter_pressed():
	emit_signal("enter_pressed")

func _on_Boat_input_event(viewport, event, shape_idx):
	if event.is_action_pressed('ui_touch'):
		$PopupControlPlayer.open($Boat.get_global_position())
		get_tree().set_input_as_handled()

# player boat is attacking an enemy boat
func attacking(node):
	$Boat.set_state_attacking(node)
