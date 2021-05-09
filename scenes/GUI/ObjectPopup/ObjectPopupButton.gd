extends Button

export var btn_text = "button"
export var btn_color = Color(0, 0, 0, 255)

# Called when the node enters the scene tree for the first time.
func _ready():
	print(btn_color)
	render_node()
	
func render_node():
	text = btn_text
	modulate = btn_color

func set_text(txt):
	btn_text = txt
	
func set_color(color):
	btn_color = color
