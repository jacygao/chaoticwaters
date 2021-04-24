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
			pass

func default():
	reset()
	$CityPanel.visible = true

func reset():
	$CityPanel.visible = false
	$PalacePanel.visible = false
	$HotelPanel.visible = false

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
	pass # Replace with function body.

func _on_HotelPanel_recover_all():
	pass # Replace with function body.

func _on_HotelPanel_leave():
	default()

func _on_DialogUI_dialog_played(key):
	match key:
		"first_city_visit":
			$TutorialUI.set_pos(tutorial_position_offset($CityPanel/Hotel))
			$TutorialUI.open()
		"city_hotel":
			$TutorialUI.set_pos(tutorial_position_offset($HotelPanel/OneNightButton))
			$TutorialUI.open()
		
func tutorial_position_offset(node):
	var pos = node.get_position()
	var size = node.get_size()
	
	pos.x = pos.x + size.x/2 + 40
	pos.y = pos.y + size.y/2 + 40
	return pos
