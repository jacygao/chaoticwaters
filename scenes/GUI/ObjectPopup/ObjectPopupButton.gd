extends Button

export var btn_text = "button"
export var btn_color = Color(0, 0, 0, 255)

# Called when the node enters the scene tree for the first time.
func _ready():
	render_node()
	
func render_node():
	text = btn_text
	modulate = btn_color
