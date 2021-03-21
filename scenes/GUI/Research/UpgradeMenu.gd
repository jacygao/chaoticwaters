extends Panel

signal close_pressed

onready var upgrade_info_menu = get_node("UpgradeInfoMenu")
var research_sys = preload("res://systems/Research.gd").new()
var research_mata_data = preload("res://meta/Research.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready():
	upgrade_info_menu.visible = false

func _on_FireUpgrade_button_pressed():
	open_upgrade_info_menu($FireUpgrade, research_mata_data.get_meta("cannon"))

func _on_ArmorUpgrade_button_pressed():
	open_upgrade_info_menu($ArmorUpgrade, research_mata_data.get_meta("deck"))

func _on_SpeedUpgrade_button_pressed():
	open_upgrade_info_menu($SpeedUpgrade, research_mata_data.get_meta("sail"))

func _on_VisibilityButton_button_pressed():
	open_upgrade_info_menu($VisibilityUpgrade, research_mata_data.get_meta("spyglass"))

func _on_PopupToolbar_close_button_pressed():
	emit_signal("close_pressed")

func open_upgrade_info_menu(node, meta):
	var cur_level = research_sys.get_level(node.id)
	var next_level = cur_level + 1
	upgrade_info_menu.set_id(node.id)
	upgrade_info_menu.set_cur_level(cur_level)
	upgrade_info_menu.set_icon_path(node.texture_path)
	upgrade_info_menu.set_cost(meta[next_level]["upgrade_cost"])
	upgrade_info_menu.set_effect(research_mata_data.get_boost_st(meta[next_level]["boost"]))
	upgrade_info_menu.set_research_time(meta[next_level]["research_time"])
	upgrade_info_menu.render_node()
	upgrade_info_menu.visible = true
	
func _on_UpgradeInfoMenu_close_button_pressed():
	upgrade_info_menu.visible = false

func _on_UpgradeInfoMenu_upgrade_button_pressed(id):
	research_sys.upgrade(id)
