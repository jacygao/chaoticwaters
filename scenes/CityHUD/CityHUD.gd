extends CanvasLayer

export var city_name = "Stockholm"

var population = 134567
var economy = 1880
var defence = 2000
var forces = {}

enum {PALACE, BAR, SHOP, HOTEL, SHIPYARD}

# Called when the node enters the scene tree for the first time.
func _ready():
	render_node()
	default()
	$DialogUI.new_dialog("first_city_visit")

func render_node():
	var city_data = City.get_city(city_name)
	population = City.get_population(city_data)
	economy = City.get_economy(city_data)
	defence = City.get_defence(city_data)
	forces = City.get_forces(city_data)
	print(forces)
	render_info_panel()
	
func render_info_panel():
	$InfoPanel.set_population(population)
	$InfoPanel.set_economy(economy)
	$InfoPanel.set_defence(defence)
	$InfoPanel.set_forces(forces)

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
			$TutorialUI.close()
			$DialogUI.new_dialog("city_shop")
			$ShopPanel.visible = true
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
	$ShopPanel.visible = false
	$TradePanel.visible = false

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
			default()
			$TutorialUI.close()
			$DialogUI.new_dialog("first_trade")
		"first_trade":
			$TutorialUI.set_pos(Utils.tutorial_position_offset($CityPanel/Shop))
			$TutorialUI.open()
		"city_shop":
			$TutorialUI.set_pos(Utils.tutorial_position_offset($ShopPanel/TradeButton))
			$TutorialUI.open()
"""
	Palace
"""
func _on_PalacePanel_leave():
	default()

func _on_PalacePanel_invest():
	$TutorialUI.close()
	if Economy.deduct_coins(economy):
		City.occupy(city_name, Player.get_name(), 1)
		render_node()
		$DialogUI.new_dialog("after_city_investment")

func _on_PalacePanel_invest_10():
	if Economy.deduct_coins(economy * 10):
		City.occupy(city_name, Player.get_name(), 10)
		render_node()
		$DialogUI.new_dialog("after_city_investment")
		
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

"""
	Shop
"""
func enter_shop():
	$TradePanel.visible = true

func _on_ShopPanel_trade():
	enter_shop()

func _on_TradePanel_buy(id, price):
	if !Economy.deduct_coins(price):
		pass

func _on_TradePanel_sell(id, price):
	Economy.add_coins(price)
