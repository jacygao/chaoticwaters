extends CanvasLayer

export var city_name = "Stockholm"
export var economy = 1880

var stats_widget = preload("res://scenes/CityHUD/StatsWidget.tscn")

enum {PALACE, BAR, SHOP, HOTEL, SHIPYARD}

# Called when the node enters the scene tree for the first time.
func _ready():
	init()
	default()
	$DialogUI.new_dialog("first_city_visit")

func init():
	$InfoPanel.set_economy(economy)

func _on_CityPanel_pressed(btn):
	reset()
	match btn:
		PALACE:
			$TutorialUI.close()
			$DialogUI.new_dialog("city_investment")
			$PalacePanel.visible = true
		BAR:
			pass
		SHOP:
			pass
		HOTEL:
			$TutorialUI.close()
			$DialogUI.new_dialog("city_hotel")
			$HotelPanel.visible = true
		SHIPYARD:
			$TutorialUI.close()
			$DialogUI.new_dialog("city_shipyard")
			$ShipyardPanel.visible = true

func default():
	reset()
	$CityPanel.visible = true

func reset():
	$CityPanel.visible = false
	$PalacePanel.visible = false
	$HotelPanel.visible = false
	$ShipyardPanel.visible = false

func _on_DialogUI_dialog_played(key):
	match key:
		"first_city_visit":
			$TutorialUI.set_pos(Utils.tutorial_position_offset($CityPanel/Hotel))
			$TutorialUI.open()
		"city_hotel":
			$TutorialUI.set_pos(Utils.tutorial_position_offset($HotelPanel/OneNightButton))
			$TutorialUI.open()
		"first_shipyard_visit":
			$TutorialUI.set_pos(Utils.tutorial_position_offset($CityPanel/Shipyard))
			$TutorialUI.open()
		"city_shipyard":
			$TutorialUI.set_pos(Utils.tutorial_position_offset($ShipyardPanel/RepairButton))
			$TutorialUI.open()
		"first_occupation":
			$TutorialUI.set_pos(Utils.tutorial_position_offset($CityPanel/Palace))
			$TutorialUI.open()
		"city_investment":
			$TutorialUI.set_pos(Utils.tutorial_position_offset($PalacePanel/InvestButton))
			$TutorialUI.open()
		"after_city_investment":
			$TutorialUI.close()
			default()
"""
	Palace
"""
func _on_PalacePanel_leave():
	default()

func _on_PalacePanel_invest():
	$TutorialUI.close()
	Player.occupy(city_name, 1)
	Economy.deduct_coins(economy)
	$DialogUI.new_dialog("after_city_investment")

func _on_PalacePanel_invest_10():
	Player.occupy(city_name, 10)
	$DialogUI.new_dialog("after_city_investment")
	
func render_force_panel():
	#TODO: rendering city forces dynamically
	pass
		
"""
	Hotel
"""
func _on_HotelPanel_one_night():
	# TODO: make it configurable
	Statistic.subtract_fatigue(5)
	default()
	$TutorialUI.close()
	$DialogUI.new_dialog("first_shipyard_visit")
		
func _on_HotelPanel_recover_all():
	Statistic.reset_fatigue()
	$TutorialUI.close()
	default()
	
func _on_HotelPanel_leave():
	default()

"""
	Shipyard
"""

func _on_ShipyardPanel_repair():
	Statistic.reset_health()
	default()
	$TutorialUI.close()
	$DialogUI.new_dialog("first_occupation")
	
func _on_ShipyardPanel_leave():
	default()
