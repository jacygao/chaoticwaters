extends CanvasLayer

enum {PALACE, BAR, SHOP, HOTEL, SHIPYARD}

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()
	$CityPanel.visible = true

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
			$DialogUI.new_dialog("city_hotel")
			$HotelPanel.visible = true
		SHIPYARD:
			pass

func reset():
	$CityPanel.visible = false
	$PalacePanel.visible = false
	$HotelPanel.visible = false

"""
	Palace
"""
func _on_PalacePanel_leave():
	reset()
	$CityPanel.visible = true

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
