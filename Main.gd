extends Node

# Declare member variables here. Examples:
export var fire_rate = 2.0
export var coins = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD/FireButtonRight.call("set_cooldown", fire_rate)
	$HUD/FireButtonLeft.call("set_cooldown", fire_rate)
	update_coins(coins)
	
func _on_AnchorButton_anchor_on():
	$PlayerBoat.call("anchor_on")

func _on_AnchorButton_anchor_off():
	$PlayerBoat.call("anchor_off")

func _on_CityStockholm_city_entered():
	$HUD/PopupMenu.visible = true

func _on_CityStockholm_city_exited():
	if $HUD/PopupMenu.visible:
		$HUD/PopupMenu.hide()

func _on_FireButtonRight_button_pressed():
	$PlayerBoat.call("fire_animate_right")

func _on_FireButtonLeft_button_pressed():
	$PlayerBoat.call("fire_animate_left")

# Economy section starts here
func _on_PopupMenu_fire_upgrade_pressed(cost):
	if cost <= coins:
		$PlayerBoat.fire_damage+=1
		update_coins(coins-cost)
	else:	
		show_warn_message("insufficient funds")

func _on_PopupMenu_armor_upgrade_pressed(cost):
	if cost <= coins:
		$PlayerBoat.max_durability+=1
		$PlayerBoat.durability+=1
		$PlayerBoat.call("update_durability")
		update_coins(coins-cost)
	else:	
		show_warn_message("insufficient funds")
		
func update_coins(c):
	coins = c
	$HUD.update_coins(coins)

func show_warn_message(msg):
	$HUD.show_message($HUD.message_level_warn, msg)

func _on_BoatDisappearTimer_timeout():
	$NPCBoat.queue_free()
	$BoatDisappearTimer.stop()

func _on_NPCBoat_sinking():
	$BoatDisappearTimer.start()
