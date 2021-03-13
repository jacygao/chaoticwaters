extends Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_coins(num):
	$CoinWidget.update_number(num)

func minus_coins(num):
	if !$CoinWidget.is_sufficient(num):
		return false
	$CoinWidget.minus(num)
	return true
	
func plus_coins(num):
	$CoinWidget.plus(num)
