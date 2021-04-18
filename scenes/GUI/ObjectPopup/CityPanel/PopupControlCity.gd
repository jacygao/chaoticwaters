extends Node2D

# pos - a Vector2D defining the popup position.
func open(pos):
	$ObjectPopupPanel.popup()
	$ObjectPopupPanel.set_global_position(pos)
	
func get_popup_size():
	return $ObjectPopupPanel.rect_size
