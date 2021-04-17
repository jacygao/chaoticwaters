extends Node2D

export var level = 1

var meta = {}

signal attack_pressed(node)
signal sinking_boat_pressed(node)
signal boat_cleared

# Called when the node enters the scene tree for the first time.
func _ready():
	meta = NPC_Meta.get_pirate_boat(level)
	$Boat.init_node(NPC_Meta.get_stats_damage(meta), NPC_Meta.get_stats_health(meta))

func get_items():
	return NPC_Meta.get_items(meta)

func _on_PlayerBoat_input_event(viewport, event, shape_idx):
	if event.is_action_pressed('ui_touch'):
		if $Boat.state() == $Boat.SINKING:
			# If boat is sinking, display the reward popup for player to loot
			# Reward popup is controled by the parent node, thus emit signal here.
			emit_signal("sinking_boat_pressed", self)
			return
		# display popup in the most appropriate position.
		# if popup width is greater that the object position to the edge of viewport,
		# render popup on the mirror side of its Y axis.
		print($Boat.get_global_transform_with_canvas().get_origin().x)
		print(get_viewport().size.x)
		if get_viewport().size.x - $Boat.get_global_transform_with_canvas().get_origin().x >= $PopupControlPirate.get_popup_size().x:
			$PopupControlPirate.open($Boat.get_global_position())
		else:
			var pos = $Boat.get_global_position()
			pos.x -= $PopupControlPirate.get_popup_size().x
			$PopupControlPirate.open(pos)
			
		get_tree().set_input_as_handled()
			
func _on_PopupControlPirate_is_attacked():
	$Boat.set_state_attacked()
	emit_signal("attack_pressed", $Boat)

func _on_Boat_is_sinking():
	$SinkTimer.start()

func _on_SinkTimer_timeout():
	print("time out triggered")
	clear_node()

func clear_node():
	emit_signal("boat_cleared")
	queue_free()
