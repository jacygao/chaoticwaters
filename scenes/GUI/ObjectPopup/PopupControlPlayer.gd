extends Node2D

signal enter_pressed

# pos - a Vector2D defining the popup position.
func open(pos):
	$ObjectPopupPanel.set_global_position(pos)
	$ObjectPopupPanel.popup()
	
func close():
	$ObjectPopupPanel.hide()

func _on_PlayerPopupPanel_enter_button_pressed():
	emit_signal("enter_pressed")
	close()
