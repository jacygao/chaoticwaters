extends Node2D

signal enter_pressed(node)

# pos - a Vector2D defining the popup position.
func open(pos):
	$ObjectPopupPanel.popup()
	$ObjectPopupPanel.set_global_position(pos)
	
func close():
	$ObjectPopupPanel.hide()
	
func get_popup_size():
	return $ObjectPopupPanel.rect_size

func _on_CityPanel_enter_pressed():
	emit_signal("enter_pressed", self)
	close()
