extends Panel

var info_panel = preload("res://scenes/CityHUD/StatsWidget.tscn")

func render(forces:Dictionary):
	reset()
	var pos_x = 0
	var pos_y = 0
	for key in forces:
		var node = info_panel.instance()
		node.title = key
		node.number = String(forces[key])+"%"
		node.set_position(Vector2(pos_x, pos_y))
		node.margin_left = 30
		add_child(node)
		pos_y += 40

func reset():
	for child in get_children():
		child.queue_free()
