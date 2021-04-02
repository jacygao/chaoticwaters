extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func new_dialog(key):
	var dialog = Dialog_Meta.load_dialog(key)
	$DialogBox.open_dialog(dialog)
	visible = true

func _on_DialogBox_dialog_is_finished():
	visible = false
