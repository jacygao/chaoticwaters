extends TextureButton

var world_view_on = preload("res://assets/icons/sailboat.png")
var world_view_off = preload("res://assets/icons/position-marker.png")

var is_world_view_on = false

signal world_view_on
signal world_view_off

# Called when the node enters the scene tree for the first time.
func _ready():
	self.texture_normal = world_view_off

func _on_AnchorButton_pressed():
	if is_world_view_on:
		is_world_view_on = false
		texture_normal = world_view_off
		emit_signal("world_view_off")
	else:
		is_world_view_on = true
		texture_normal = world_view_on
		emit_signal("world_view_on")
