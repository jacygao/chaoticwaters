extends Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	render_node()

func set_coins(num):
	$CoinWidget.update_number(num)

func minus_coins(num):
	if !$CoinWidget.is_sufficient(num):
		return false
	$CoinWidget.minus(num)
	return true
	
func plus_coins(num):
	$CoinWidget.plus(num)

func render_node():
	set_coins(Economy.get_coins())
