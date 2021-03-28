extends Control

# making it a dictionary for extendability
export var text = {
	0: "the first dialog",
	1: "the second dialog",
	2: "the last dialog"
}

var dialog_index = 0
var show_indicator = false

func _ready():
	load_dialog()
		
func _process(_delta):
	$Indicator.visible = show_indicator
	if show_indicator:
		if Input.is_action_just_pressed("ui_touch"):
			load_dialog()

func render_node():
	load_dialog()
	
func load_dialog():
	show_indicator = false
	if dialog_index < text.size():
		$RichTextLabel.bbcode_text = text[dialog_index]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
	else:
		queue_free()
	dialog_index+=1


func _on_Tween_tween_completed(object, key):
	show_indicator = true
	$Indicator/Animation.play()
