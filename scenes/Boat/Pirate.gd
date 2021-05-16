extends Node2D

export var level = 1

var meta = {}

signal body_pressed(popop_node)
signal attack_pressed(node)
signal sinking_boat_pressed(node)
signal boat_cleared

onready var popup_controller = $PopupControlPirate
onready var control_node = $Boat

# Called when the node enters the scene tree for the first time.
func _ready():
	meta = NPC_Meta.get_pirate_boat(level)
	$Boat.init_node(NPC_Meta.get_stats_damage(meta), NPC_Meta.get_stats_health(meta))

func get_items():
	return NPC_Meta.get_items(meta)

func get_state():
	return $Boat.state()

func show_tutorial():
	# adjust tutorial to be at the most appropriate spot
	$TutorialUI.position = $Boat.position + Vector2(40, 40)
	$TutorialUI.open()

func hide_tutorial():
	$TutorialUI.close()

func show_popup_tutorial():
	$PopupControlPirate.show_tutorial()
	
func hide_popup_tutorial():
	$PopupControlPirate.hide_tutorial()

func _on_PlayerBoat_input_event(viewport, event, shape_idx):
	if event.is_action_pressed('ui_touch'):
		if get_state() == $Boat.SINKING:
			# If boat is sinking, display the reward popup for player to loot
			# Reward popup is controled by the parent node, thus emit signal here.
			emit_signal("sinking_boat_pressed", self)
			return

		# display popup in the most appropriate position.
		# if popup width is greater that the object position to the edge of viewport,
		# render popup on the mirror side of its Y axis.
		var pos = control_node.get_global_position()
		if get_viewport().size.x - control_node.get_global_transform_with_canvas().get_origin().x < popup_controller.get_popup_size().x:
			pos.x -= popup_controller.get_popup_size().x
		if get_viewport().size.y - control_node.get_global_transform_with_canvas().get_origin().y < popup_controller.get_popup_size().y:
			pos.y -= popup_controller.get_popup_size().y
			
		popup_controller.open(pos)
		emit_signal("body_pressed", $PopupControlPirate)
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

func _on_Boat_state_changed(state):
	if state == $Boat.BATTLING:
		$PopupControlPirate/ObjectPopupPanel/PiratePopupPanel/PirateAttackButton.disabled = true
	else:
		$PopupControlPirate/ObjectPopupPanel/PiratePopupPanel/PirateAttackButton.disabled = false
