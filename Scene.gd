extends Node

var packed_scene = PackedScene.new()
packed_scene.pack(get_tree().get_current_scene())
ResourceSaver.save("res://my_scene.tscn", packed_scene)

# Load the PackedScene resource
var packed_scene = load("res://my_scene.tscn")
# Instance the scene
var my_scene = packed_scene.instance()
add_child(my_scene)
