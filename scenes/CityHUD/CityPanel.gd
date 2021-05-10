extends Panel

signal pressed(btn)

enum {PALACE, BAR, SHOP, HOTEL, SHIPYARD}

func _on_Palace_pressed():
	emit_signal("pressed", get_parent().PALACE)

func _on_Bar_pressed():
	emit_signal("pressed", get_parent().BAR)

func _on_Shop_pressed():
	emit_signal("pressed", get_parent().SHOP)

func _on_Hotel_pressed():
	emit_signal("pressed", get_parent().HOTEL)

func _on_Shipyard_pressed():
	emit_signal("pressed", get_parent().SHIPYARD)

func _on_Dock_pressed():
	emit_signal("pressed", get_parent().DOCK)
