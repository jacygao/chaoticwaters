extends Node

# Size of the game window.
var screen_size
# Add this variable to hold the clicked position.
var target = Vector2()

var mouse_entered = false

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

func _on_Boat_is_clicked():
	print("clicked")

func _on_NPCBoat_is_attacked(node):
	$Boat.set_state_attacking(node)
