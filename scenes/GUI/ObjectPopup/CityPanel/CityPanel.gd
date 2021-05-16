extends Panel

signal enter_pressed

func render_city_name(name:String):
	$Label.text = name

func _on_ObjectPopupButton_pressed():
	emit_signal("enter_pressed")
