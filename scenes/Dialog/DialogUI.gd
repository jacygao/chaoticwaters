extends Control

var dialog_key = ""

signal dialog_played(key)

func new_dialog(key):
	if !Dialog.has_played(key):
		dialog_key = key
		var dialog = Dialog_Meta.load_dialog(dialog_key)
		print(dialog)
		$DialogBox.open_dialog(dialog)
		visible = true

func _on_DialogBox_dialog_is_finished():
	if Dialog_Meta.is_once(dialog_key):
		Dialog.save(dialog_key)
	visible = false
	emit_signal("dialog_played", dialog_key)
