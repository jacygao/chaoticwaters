extends Node

# Size of the game window.
var screen_size
# Add this variable to hold the clicked position.
var target = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = $Boat/Camera2D.position
	target = $Boat/Camera2D.position

func _unhandled_input(event):
	if event.is_action_pressed('ui_touch'):
		print("touch detected")
		if !$Boat.isAnchorOn:
			target = $Boat.get_global_mouse_position()
			$Boat.set_target(target)
			
func _input_event(event):
	print(event)

func anchor_on():
	$Boat.anchor_on()

func anchor_off():
	$Boat.anchor_off()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
