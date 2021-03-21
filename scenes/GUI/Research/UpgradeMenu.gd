extends Panel

onready var upgrade_info_menu = get_node("UpgradeInfoMenu")
var is_upgrading = false

signal close_pressed
signal research_item_upgraded(id)
signal research_item_upgrad_started(id)

# Called when the node enters the scene tree for the first time.
func _ready():
	upgrade_info_menu.visible = false
	render_node()
	
func render_node():
	# TODO: can we simplify this?
	var level = 0
	var key = ""
	
	key = "cannon"
	level = Research.get_level(key)
	if Research_Meta.can_upgrade(key, level+1):
		$FireUpgrade/PriceTag.text = String(Research_Meta.get_upgrade_cost(key, level+1))
	else: 
		$FireUpgrade/PriceTag.text = "max"
		
	key = "deck"
	level = Research.get_level(key)
	if Research_Meta.can_upgrade(key, level+1):
		$ArmorUpgrade/PriceTag.text = String(Research_Meta.get_upgrade_cost(key, level+1))
	else:
		$ArmorUpgrade/PriceTag.text = "max"
		
	key = "sail"
	level = Research.get_level(key)
	if Research_Meta.can_upgrade(key, level+1):
		$SpeedUpgrade/PriceTag.text = String(Research_Meta.get_upgrade_cost(key, level+1))
	else:
		$SpeedUpgrade/PriceTag.text = "max"
		
	key = "spyglass"
	level = Research.get_level(key)
	if Research_Meta.can_upgrade(key, level+1):
		$VisibilityUpgrade/PriceTag.text = String(Research_Meta.get_upgrade_cost(key, level+1))
	else:
		$VisibilityUpgrade/PriceTag.text = "max"
	
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
		var upgrade_cost = level_meta["upgrade_cost"]
		upgrade_info_menu.set_cost(upgrade_cost)
		upgrade_info_menu.set_effect(Research_Meta.get_boost_st(level_meta["boost"]))
		upgrade_info_menu.set_research_time(level_meta["research_time"])
		
		if !is_upgrading:
			upgrade_info_menu.set_button_cooldown(level_meta["research_time"])
			
		upgrade_info_menu.render_node()
		
		if !Economy.is_insufficient(upgrade_cost):
			upgrade_info_menu.set_cost_insufficent()
			upgrade_info_menu.hide_upgrade_button()
		else:
			upgrade_info_menu.set_cost_sufficent()
			
	upgrade_info_menu.visible = true
	
func _on_UpgradeInfoMenu_close_button_pressed():
	upgrade_info_menu.visible = false

func _on_UpgradeInfoMenu_upgrade_button_time_out(id):
	is_upgrading = false
	emit_signal("research_item_upgraded", id)
	render_node()
	
func _on_UpgradeInfoMenu_upgrade_button_pressed(id):
	is_upgrading = true
	emit_signal("research_item_upgrad_started", id)
