extends CanvasLayer

enum {message_level_info, message_level_warn}

onready var economy = $EconomyMenu
onready var stats = $StatisticPanel
onready var message_panel = $MessagePanel

# Called when the node enters the scene tree for the first time.
func _ready():
	economy.set_coins(Economy.get_coins())
	$DialogUI.new_dialog("game_start")

func update_coins(coins):
	economy.set_coins(Economy.get_coins())

func minus_coins(coins):
	if !economy.minus_coins(coins):
		show_message(message_level_warn, "insufficient funds")
		return false
	return true
	
func show_message(level, message):
	var color = Color(0, 0, 0, 1)
	match level:
		message_level_info:
			color = Color(0, 1, 0, 1)
		message_level_warn:
			color = Color(1, .19, .19, 1)
			
	message_panel.text = message
	message_panel.self_modulate = color
	message_panel.visible = true
	$MessagePanelTimer.start()

func render_node():
	economy.render_node()

func _on_MessagePanelTimer_timeout():
	$MessagePanelTimer.stop()
	message_panel.visible = false

func _on_BarMenu_upgrade_button_pressed():
	$ShipBuilder.visible = true

func _on_BarMenu_research_button_pressed():
	$ResearchPopupMenu.visible = true

func _on_UpgradePopupMenu_close_pressed():
	$ResearchPopupMenu.visible = false
		
func _on_ResearchPopupMenu_research_item_upgraded(id):
	Research.upgrade(id)
	show_message(message_level_info, "%s upgrade completed" % id)

func _on_ResearchPopupMenu_research_item_upgrad_started(id):
	var new_level = Research.get_level(id)+1
	var cost = Research_Meta.get_upgrade_cost(id, new_level)
	Economy.deduct_coins(cost)
	render_node()
