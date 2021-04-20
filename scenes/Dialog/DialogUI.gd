extends Control

var dialog_key = ""

signal dialog_played(key)

func new_dialog(key):
	if !Dialog.has_played(key):
		dialog_key = key
		var dialog = Dialog_Meta.load_dialog(dialog_key)
		$DialogBox.open_dialog(dialog)
		visible = true

func _on_DialogBox_dialog_is_finished():
	Dialog.save(dialog_key)
	visible = false
	emit_signal("dialog_played", dialog_key)
