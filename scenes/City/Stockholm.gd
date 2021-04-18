extends Node2D

onready var popup_controller = $PopupControlCity
onready var control_node = $City

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_City_input_event(viewport, event, shape_idx):
	print("clicked")
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
			
		get_tree().set_input_as_handled()
