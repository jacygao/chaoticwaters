extends Node2D

signal enter_pressed

func _process(delta):
	$ObjectPopupPanel.set_global_position(get_parent().position)

# pos - a Vector2D defining the popup position.
func open(pos):
	$ObjectPopupPanel.popup()
	
func close():
	$ObjectPopupPanel.hide()

func _on_PlayerPopupPanel_enter_button_pressed():
	emit_signal("enter_pressed")
	close()
