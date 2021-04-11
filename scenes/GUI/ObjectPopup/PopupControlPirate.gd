extends Node2D

signal is_attacked

func _ready():
	close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_rotation = 0

# pos - a Vector2D defining the popup position.
func open(pos):
	$ObjectPopupPanel.popup()
	$ObjectPopupPanel.set_global_position(pos)
	
func close():
	$ObjectPopupPanel.hide()

func _on_PiratePopupPanel_attack_button_pressed():
	emit_signal("is_attacked")
	close()
