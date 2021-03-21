extends Panel

onready var upgrade_info_menu = get_node("UpgradeInfoMenu")

signal close_pressed
signal research_item_upgraded(id)
signal research_item_upgrad_started(id)

# Called when the node enters the scene tree for the first time.
func _ready():
	upgrade_info_menu.visible = false

func _on_FireUpgrade_button_pressed():
	open_upgrade_info_menu($FireUpgrade, "cannon")

func _on_ArmorUpgrade_button_pressed():
	open_upgrade_info_menu($ArmorUpgrade, "deck")

func _on_SpeedUpgrade_button_pressed():
	open_upgrade_info_menu($SpeedUpgrade, "sail")

func _on_VisibilityButton_button_pressed():
	open_upgrade_info_menu($VisibilityUpgrade, "spyglass")

func _on_PopupToolbar_close_button_pressed():
	emit_signal("close_pressed")

func open_upgrade_info_menu(node, meta_key):
	var cur_level = Research.get_level(meta_key)
	var max_level = Research_Meta.get_meta_max_level(meta_key)
	upgrade_info_menu.set_id(meta_key)
	upgrade_info_menu.set_cur_level(cur_level)
	upgrade_info_menu.set_max_level(max_level)
	upgrade_info_menu.set_icon_path(node.texture_path)

	if cur_level >= max_level:
		upgrade_info_menu.render_node()
		upgrade_info_menu.hide_upgrade_button()
		
	else:
		var next_level = cur_level + 1
		var level_meta = Research_Meta.get_meta_level(meta_key, next_level)
		upgrade_info_menu.set_cost(level_meta["upgrade_cost"])
		upgrade_info_menu.set_effect(Research_Meta.get_boost_st(level_meta["boost"]))
		upgrade_info_menu.set_research_time(level_meta["research_time"])
		upgrade_info_menu.render_node()
		
	upgrade_info_menu.visible = true
	
func _on_UpgradeInfoMenu_close_button_pressed():
	upgrade_info_menu.visible = false

func _on_UpgradeInfoMenu_upgrade_button_time_out(id):
	emit_signal("research_item_upgraded", id)

func _on_UpgradeInfoMenu_upgrade_button_pressed(id):
	emit_signal("research_item_upgrad_started", id)
