extends TextureButton

var anchor_on = preload("res://assets/icons/ship-bow.png")
var anchor_off = preload("res://assets/icons/anchor.png")

var is_anchor_on = false

signal anchor_on
signal anchor_off

# Called when the node enters the scene tree for the first time.
func _ready():
	on()

func on():
	is_anchor_on = true
	texture_normal = anchor_on

func off():
	is_anchor_on = false
	texture_normal = anchor_off

func is_on():
	return is_anchor_on == true

func _on_AnchorButton_pressed():
	if is_anchor_on:
		off()
		emit_signal("anchor_off")
	else:
		on()
		emit_signal("anchor_on")
