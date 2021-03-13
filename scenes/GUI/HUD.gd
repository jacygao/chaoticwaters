extends CanvasLayer

enum {message_level_info, message_level_warn}

var coins = 20000

# Called when the node enters the scene tree for the first time.
func _ready():
	update_coins(coins)

func update_coins(coins):
	$EconomyMenu.set_coins(coins)

func show_message(level, message):
	var color = Color(0, 0, 0, 1)
	match level:
		message_level_info:
			color = Color(0, 0, 0, 1)
		message_level_warn:
			color = Color(1, .19, .19, 1)
			
	$MessagePanel.text = message
	$MessagePanel.self_modulate = color
	$MessagePanel.visible = true
	$MessagePanelTimer.start()

func _on_MessagePanelTimer_timeout():
	$MessagePanelTimer.stop()
	$MessagePanel.visible = false

func _on_BarMenu_upgrade_button_pressed():
	$UpgradePopupMenu.visible = true
