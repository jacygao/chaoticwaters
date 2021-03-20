extends Panel

export var icon_path = "res://assets/icons/cannon_shot_plus.png"

onready var upgrade_info_panel = get_node("UpgradeInfo")

signal upgrade_button_pressed
signal close_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	render_node()

func set_cur_level(lvl):
	upgrade_info_panel.set_cur_level(lvl)
	
func set_effect(desc):
	upgrade_info_panel.set_effect(desc)

func set_cost(val):
	upgrade_info_panel.set_cost(val)
	
func set_research_time(t):
	upgrade_info_panel.set_research_time(t)

func set_icon_path(path):
	icon_path = path

func render_node():
	$Icon.texture = load(icon_path)
	upgrade_info_panel.render_node()

func _on_UpgradeButton_button_pressed():
	emit_signal("upgrade_button_pressed")

func _on_PopupToolbar_close_button_pressed():
	emit_signal("close_button_pressed")
