extends Panel

export var label = "label"
export (int) var text = 0
export (Color) var font_color = Color(1,0,0,1)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_label(label)
	set_text(text)

func plus(num):
	text+=num
	set_text(text)
	
func set_label(txt):
	$Label.text = txt
	$Label.add_color_override("font_color", font_color)
	
func set_text(num):
	$Text.text = String(num)
	$Text.add_color_override("font_color", font_color)
