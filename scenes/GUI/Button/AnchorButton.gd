extends TextureButton

var anchor_on = preload("res://assets/icons/ship-bow.png")
var anchor_off = preload("res://assets/icons/anchor.png")

var is_anchor_on = false

signal anchor_on
signal anchor_off

# Called when the node enters the scene tree for the first time.
func _ready():
	self.texture_normal = anchor_off


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_AnchorButton_pressed():
	if is_anchor_on:
		is_anchor_on = false
		texture_normal = anchor_off
		emit_signal("anchor_off")
	else:
		is_anchor_on = true
		texture_normal = anchor_on
		emit_signal("anchor_on")
