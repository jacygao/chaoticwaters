extends CanvasLayer

enum {message_level_info, message_level_warn}

var coins = 20000

onready var economy = $EconomyMenu
onready var stats = $StatisticPanel
onready var message_panel = $MessagePanel

# Called when the node enters the scene tree for the first time.
func _ready():
	update_coins(coins)

func update_coins(coins):
	economy.set_coins(coins)

func minus_coins(coins):
	if !economy.minus_coins(coins):
		show_message(message_level_warn, "insufficient funds")
		return false
	return true
	
func show_message(level, message):
	var color = Color(0, 0, 0, 1)
	match level:
		message_level_info:
			color = Color(0, 0, 0, 1)
		message_level_warn:
			color = Color(1, .19, .19, 1)
			
	message_panel.text = message
	message_panel.self_modulate = color
	message_panel.visible = true
	$MessagePanelTimer.start()

func _on_MessagePanelTimer_timeout():
	$MessagePanelTimer.stop()
	message_panel.visible = false

func _on_BarMenu_upgrade_button_pressed():
	$UpgradePopupMenu.visible = true

func _on_UpgradePopupMenu_close_pressed():
	$UpgradePopupMenu.visible = false

func _on_UpgradePopupMenu_armor_upgrade_pressed(cost):
	if minus_coins(cost):
		stats.set_health(stats.health+1)

func _on_UpgradePopupMenu_fire_upgrade_pressed(cost):
	if minus_coins(cost):
		stats.set_damage(stats.damage+1)

func _on_UpgradePopupMenu_speed_upgrade_pressed(cost):
	if minus_coins(cost):
		stats.set_speed(stats.speed+10)