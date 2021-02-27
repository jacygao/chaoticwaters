extends Node


# Declare member variables here. Examples:
export var fire_rate = 2.0
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD/FireButtonRight.call("set_cooldown", fire_rate)
	$HUD/FireButtonLeft.call("set_cooldown", fire_rate)

	$CityStockholm.rotation_degrees = 90
	
	$CityRiga.rotation_degrees = -90
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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


func _on_PopupMenu_fire_upgrade_pressed():
	$PlayerBoat.fire_damage+=1
