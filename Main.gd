extends Node

export var fire_rate = 2.0
export var coins = 200

func _ready():
	$HUD/FireButtonRight.call("set_cooldown", fire_rate)
	$HUD/FireButtonLeft.call("set_cooldown", fire_rate)
	update_coins(coins)
	
func _on_AnchorButton_anchor_on():
	$Player.call("anchor_on")

func _on_AnchorButton_anchor_off():
	$Player.call("anchor_off")

func _on_CityStockholm_city_entered():
	pass

func _on_CityStockholm_city_exited():
	pass

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

func _on_NPCBoat_is_clicked(pos):
	$ObjectPopupControl.open(pos)

# An attack button is pressed, moving player boat towards target.
func _on_Pirate_attack_pressed(node):
	$Player.attacking(node)

func _on_Player_battle_victory(node):
	$HUD/DialogUI.new_dialog("first_victory")

func _on_Pirate_sinking_boat_pressed(node):
	$HUD/RewardUI.open(node)

func _on_RewardUI_claim_all(items):
	print(items)
	for item in items:
		if Item_Meta.is_item_coin(item):
			var amount = Item_Meta.get_item_amount(item)
			$HUD.plus_coins(amount)
			$HUD.render_node()

func _on_Pirate_boat_cleared():
	$HUD/DialogUI.new_dialog("first_reward")
