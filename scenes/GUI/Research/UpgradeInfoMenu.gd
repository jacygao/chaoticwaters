extends Panel

export var icon_path = "res://assets/icons/cannon_shot_plus.png"
export var research_id = "default"

onready var upgrade_info_panel = get_node("UpgradeInfo")

signal upgrade_button_time_out(id)
signal upgrade_button_pressed(id)
signal close_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	render_node()

func set_id(id):
	research_id = id
	$UpgradeButton.id = research_id

func set_cur_level(lvl):
	upgrade_info_panel.set_cur_level(lvl)
	
func set_max_level(lvl):
	upgrade_info_panel.set_max_level(lvl)
	
func set_effect(desc):
	upgrade_info_panel.set_effect(desc)

func set_cost(val):
	upgrade_info_panel.set_cost(val)
	
func set_research_time(t):
	upgrade_info_panel.set_research_time(t)

func set_button_cooldown(t):
	$UpgradeButton.set_cooldown(t)
	
func hide_upgrade_button():
	$UpgradeButton.visible = false

func set_cost_sufficent():
	upgrade_info_panel.set_cost_sufficient()
	
func set_cost_insufficent():
	upgrade_info_panel.set_cost_insufficient()

func set_icon_path(path):
	icon_path = path

func render_node():
	$Icon.texture = load(icon_path)
	$UpgradeButton.visible = true
	upgrade_info_panel.render_node()

func upgrade(node_id, cur_level):
	var next_level = cur_level + 1
	var meta = Research_Meta.get_meta(node_id)
	set_cur_level(cur_level)
	set_cost(meta[next_level]["upgrade_cost"])
	set_effect(Research_Meta.get_boost_st(meta[next_level]["boost"]))
	set_research_time(meta[next_level]["research_time"])
	upgrade_info_panel.render_node()
	
func _on_UpgradeButton_button_pressed():
	emit_signal("upgrade_button_pressed", research_id)

func _on_PopupToolbar_close_button_pressed():
	emit_signal("close_button_pressed")

func _on_UpgradeButton_time_out(id):
	emit_signal("upgrade_button_time_out", id)

