extends CanvasLayer

onready var economy = $EconomyMenu
onready var stats = $StatisticPanel
onready var message_panel = $MessagePanel

signal ancher_on
signal ancher_off
signal world_view_on
signal world_view_off

# Called when the node enters the scene tree for the first time.
func _ready():
	economy.set_coins(Economy.get_coins())
	#$DialogUI.new_dialog("game_start")

func update_coins(coins):
	economy.set_coins(Economy.get_coins())

func minus_coins(coins):
	if !economy.minus_coins(coins):
		Notification.warn(self, "insufficient funds")
		return false
	return true
	
func plus_coins(coins):
	if Economy.add_coins(coins):
		economy.plus_coins(coins)
	
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
	Notification.info(self, "%s upgrade completed" % id)

func _on_ResearchPopupMenu_research_item_upgrad_started(id):
	var new_level = Research.get_level(id)+1
	var cost = Research_Meta.get_upgrade_cost(id, new_level)
	Economy.deduct_coins(cost)
	render_node()

func _on_AnchorButton_anchor_on():
	emit_signal("ancher_on")

func _on_AnchorButton_anchor_off():
	emit_signal("ancher_off")

func _on_WorldViewButton_world_view_on():
	emit_signal("world_view_on")

func _on_WorldViewButton_world_view_off():
	emit_signal("world_view_off")
