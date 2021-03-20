extends Panel

signal close_pressed

export var fire_upgrade_cost = 200
export var armor_upgrade_cost = 50
export var speed_upgrade_cost = 200
export var visibility_upgrade_cost = 100

onready var upgrade_info_menu = get_node("UpgradeInfoMenu")
var research_sys = preload("res://systems/Research.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$FireUpgrade/PriceTag.text = String(fire_upgrade_cost)
	$ArmorUpgrade/PriceTag.text = String(armor_upgrade_cost)
	$SpeedUpgrade/PriceTag.text = String(speed_upgrade_cost)
	$VisibilityUpgrade/PriceTag.text = String(visibility_upgrade_cost)

	upgrade_info_menu.visible = false

func _on_FireUpgrade_button_pressed():
	open_upgrade_info_menu($FireUpgrade)
	#emit_signal("fire_upgrade_pressed", fire_upgrade_cost)

func _on_ArmorUpgrade_button_pressed():
	open_upgrade_info_menu($ArmorUpgrade)
	#emit_signal("armor_upgrade_pressed", armor_upgrade_cost)

func _on_SpeedUpgrade_button_pressed():
	open_upgrade_info_menu($SpeedUpgrade)
	#emit_signal("speed_upgrade_pressed", speed_upgrade_cost)

func _on_VisibilityButton_button_pressed():
	open_upgrade_info_menu($VisibilityUpgrade)
	#emit_signal("visibility_upgrade_pressed", visibility_upgrade_cost)

func _on_PopupToolbar_close_button_pressed():
	emit_signal("close_pressed")

func open_upgrade_info_menu(node):
	upgrade_info_menu.set_id(node.id)
	upgrade_info_menu.set_cur_level(research_sys.get_level(node.id))
	upgrade_info_menu.set_icon_path(node.texture_path)
	upgrade_info_menu.set_cost(node.cost)
	upgrade_info_menu.set_effect(node.desciption)
	upgrade_info_menu.set_research_time(2)
	upgrade_info_menu.render_node()
	upgrade_info_menu.visible = true
	
func _on_UpgradeInfoMenu_close_button_pressed():
	upgrade_info_menu.visible = false

func _on_UpgradeInfoMenu_upgrade_button_pressed(id):
	research_sys.upgrade(id)
