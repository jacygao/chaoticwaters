extends Panel

export var icon_path = "res://assets/gui/icon.png"
export (int) var number = 20000

func _ready():
	$Icon.texture = load(icon_path)
	render_text(number)

func _process(_delta):
	number = Economy.get_coins()
	render_text(number)
	
func update_number(num):
	number = num
	render_text(number)

func minus(num):
	update_number(int($Number.text)-num)

func plus(num):
	update_number(int($Number.text)+num)

func is_sufficient(cost):
	return cost <= number

func render_text(num):
	$Number.text = String(num)
