extends CanvasLayer

enum {PALACE, BAR, SHOP, HOTEL, SHIPYARD}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_CityPanel_pressed(btn):
	reset()
	match btn:
		PALACE:
			$PalacePanel.visible = true
			pass
		BAR:
			pass
		SHOP:
			pass
		HOTEL:
			pass
		SHIPYARD:
			pass

func reset():
	$CityPanel.visible = false
	$PalacePanel.visible = false

func _on_PalacePanel_leave():
	reset()
	$CityPanel.visible = true

func _on_PalacePanel_invest():
	reset()
	$DialogUI.new_dialog("city_investment")
