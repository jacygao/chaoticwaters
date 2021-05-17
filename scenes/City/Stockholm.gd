extends Node2D

export var city_id = "default"

onready var popup_controller = $PopupControlCity
onready var control_node = $City

signal body_pressed(popup_node)
signal enter_pressed(node)
signal city_entered(city, node)

func _ready():
	hide_tutorial()
	$PopupControlCity.render_city_name(city_id)

func _on_City_input_event(viewport, event, shape_idx):
	if event.is_action_pressed('ui_touch'):
		# display popup in the most appropriate position.
		# if popup width is greater that the object position to the edge of viewport,
		# render popup on the mirror side of its Y axis.
		var pos = control_node.get_global_position()
		if get_viewport().size.x - control_node.get_global_transform_with_canvas().get_origin().x < popup_controller.get_popup_size().x:
			pos.x -= popup_controller.get_popup_size().x
		if get_viewport().size.y - control_node.get_global_transform_with_canvas().get_origin().y < popup_controller.get_popup_size().y:
			pos.y -= popup_controller.get_popup_size().y
			
		popup_controller.open(pos)
		emit_signal("body_pressed", $PopupControlCity)
		get_tree().set_input_as_handled()

func _on_PopupControlCity_enter_pressed(node):
	emit_signal("enter_pressed", node)

func _on_City_city_entered(node):
	emit_signal("city_entered", self, node)

func show_tutorial():
	# adjust tutorial to be at the most appropriate spot
	$TutorialUI.position = $City.position + Vector2(60, 40)
	$TutorialUI.open()
	
func hide_tutorial():
	$TutorialUI.close()

func show_popup_tutorial():
	# adjust tutorial to be at the most appropriate spot
	$PopupControlCity.show_tutorial()
	
func hide_popup_tutorial():
	$PopupControlCity.hide_tutorial()
