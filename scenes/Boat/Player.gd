extends Node

# Size of the game window.
var screen_size

signal enter_pressed
signal battle_victory(node)
signal state_change(state)

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = $Boat/Camera2D.position
	set_position(Player.get_coordinate())

func _unhandled_input(event):
	if event is InputEventScreenTouch and event.pressed:
		moving_toward_mouse_position()
		
func _process(delta):
	Player.set_coordinate(get_position())
		
func get_position():
	return $Boat.position

func set_position(pos):
	$Boat.position = pos
	
func is_player():
	return true

func anchor_on():
	$Boat.anchor_on()

func anchor_off():
	$Boat.anchor_off()

func _on_PopupControlPlayer_enter_pressed():
	emit_signal("enter_pressed")

func _on_Boat_input_event(viewport, event, shape_idx):
	if event.is_action_pressed('ui_touch'):
		$PopupControlPlayer.open($Boat.get_global_position())
		get_tree().set_input_as_handled()

# player boat is attacking an enemy boat
func attacking(node):
	$Boat.set_state_attacking(node)

func _on_Boat_battle_victory(node):
	emit_signal("battle_victory", node)

func moving_toward_mouse_position():
	$Boat.set_state_moving_toward_mouse_position()
	
func moving_toward(direction):
	$Boat.set_state_moving(direction)

func dock(node):
	$Boat.set_state_docking(node)

func idle():
	$Boat.set_default_state()

func _on_Boat_state_changed(state):
	if state == $Boat.IDLE:
		$FatigueTimer.stop()
	else:
		$FatigueTimer.start()
	emit_signal("state_change", state)
	
func _on_FatigueTimer_timeout():
	Statistic.add_fatigue(1)

func _on_Boat_is_hit(damage):
	Statistic.subtract_health(damage)

func set_world_view():
	$Boat/Camera2D.zoom_max()

func set_boat_view():
	$Boat/Camera2D.zoom_default()
