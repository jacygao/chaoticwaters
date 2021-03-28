extends Control

# If player is speaking, the portait is placed on the left side of screen. 
# Otherwise on the right side of screen.
export var is_player_speaking = true

# Called when the node enters the scene tree for the first time.
func _ready():
	render_node()

func render_node():
	if is_player_speaking:
		self.rect_position.x = 0
	else:
		self.rect_position.x = 724
		$Sprite.flip_h = true

func set_is_player_speaking(b):
	is_player_speaking = b
