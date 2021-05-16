extends Node

func _ready():
	load_main()

func load_main():
	# Load the PackedScene resource
	var packed_scene = load("res://Main.tscn")
	# Instance the scene
	var my_scene = packed_scene.instance()
	add_child(my_scene)
	my_scene.set_owner(self)
	
func save_main():
	var packed_scene = PackedScene.new()
	packed_scene.pack(get_tree().get_current_scene().get_node("Main"))
	ResourceSaver.save("res://Main.tscn", packed_scene)

func load_city():
	get_tree().change_scene("res://scenes/CityHUD/CityHUD.tscn")
