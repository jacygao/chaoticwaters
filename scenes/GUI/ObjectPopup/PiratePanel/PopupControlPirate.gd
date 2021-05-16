extends Node2D

signal is_attacked

func _ready():
	hide_tutorial()
	close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_rotation = 0

func init_node(lvl):
	$ObjectPopupPanel/PiratePopupPanel.render_title(lvl)

# pos - a Vector2D defining the popup position.
func open(pos):
	$ObjectPopupPanel.popup()
	$ObjectPopupPanel.set_global_position(pos)
	
func close():
	$ObjectPopupPanel.hide()

func get_popup_size():
	return $ObjectPopupPanel.rect_size

func _on_PiratePopupPanel_attack_button_pressed():
	emit_signal("is_attacked")
	close()

func show_tutorial():
	$ObjectPopupPanel/TutorialUI.open()
	
func hide_tutorial():
	$ObjectPopupPanel/TutorialUI.close()
