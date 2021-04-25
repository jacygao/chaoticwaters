extends CanvasLayer

enum {PALACE, BAR, SHOP, HOTEL, SHIPYARD}

# Called when the node enters the scene tree for the first time.
func _ready():
	default()
	$DialogUI.new_dialog("first_city_visit")

func _on_CityPanel_pressed(btn):
	reset()
	match btn:
		PALACE:
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

"""
	Palace
"""
func _on_PalacePanel_leave():
	default()

func _on_PalacePanel_invest():
	reset()
	$DialogUI.new_dialog("city_investment")

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

func _on_ShipyardPanel_leave():
	default()
