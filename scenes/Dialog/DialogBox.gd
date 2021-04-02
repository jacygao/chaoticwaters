extends Control

signal dialog_is_finished

# making it a dictionary for extendability
export var conversation = [
	{

		"is_player_speaking": false,
		"name": "sailor",
		"portrait_file_name": "portait-2-4.png",
		"text": "Captain, pirate ship spotted at 3 o'clock. Please give order!",
	},
	{
		"is_player_speaking": true,
		"name": "captain",
		"portrait_file_name": "portait-1-2.png",
		"text": "Fire.",
	},
	{
		"is_player_speaking": false,
		"name": "sailor",
		"portrait_file_name": "portait-2-4.png",
		"text": "Yes sir!",
	},
]

export var is_player_speaking = true
var dialog_index = 0
var show_indicator = false
var portrait_path_prefix = "res://assets/portaits/"
var portrait_path = ""

func _ready():
	render_node()
		
func _process(_delta):
	$Indicator.visible = show_indicator
	if show_indicator:
		if Input.is_action_just_pressed("ui_touch"):
			load_dialog()

func set_dialog(dialog):
	conversation = dialog

func render_node():
	load_dialog()
	load_portait()
	
func load_dialog():
	show_indicator = false
	if dialog_index < conversation.size():
		set_is_player_speaking(conversation[dialog_index].is_player_speaking)
		set_portrait_path("%s%s" % [portrait_path_prefix, conversation[dialog_index].portrait_file_name])
		load_portait()
		
		$RichTextLabel.bbcode_text = conversation[dialog_index].text
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
	else:
		close_dialog()
	dialog_index+=1

func close_dialog():
	emit_signal("dialog_is_finished")

func _on_Tween_tween_completed(object, key):
	show_indicator = true
	$Indicator/Animation.play()

func load_portait():
	$DialogPortait/Sprite.texture = load(portrait_path)
	if is_player_speaking:
		$DialogPortait.rect_position.x = 0
		$DialogPortait/Sprite.flip_h = false
	else:
		$DialogPortait.rect_position.x = 724
		$DialogPortait/Sprite.flip_h = true

func set_is_player_speaking(b):
	is_player_speaking = b

func set_portrait_path(p):
	portrait_path = p
