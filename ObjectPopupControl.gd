extends Node2D

func _ready():
	close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_rotation = 0

# pos - a Vector2D defining the popup position.
func open(pos):
	$ObjectPopupPanel.set_global_position(pos)
	$ObjectPopupPanel.popup()
	
func close():
	visible = false
