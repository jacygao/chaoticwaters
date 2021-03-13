extends Panel

export var label = "label"
export (int) var text = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_label(label)
	set_text(text)

func plus(num):
	text+=num
	set_text(text)
	
func set_label(txt):
	$Label.text = txt
	
func set_text(num):
	$Text.text = String(num)
