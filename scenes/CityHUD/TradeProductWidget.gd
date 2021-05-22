extends Panel

enum {BUY, SELL}

export var product_id = "fish"
export var quantity = 10
export var mode = BUY
export var price = 0
export var icon = ""

signal pressed(pid, cost)

# Called when the node enters the scene tree for the first time.
func _ready():
	var item = Item_Meta.get(product_id)
	price = Item_Meta.get_value(item)
	$Button.icon = load(Env.ITEM_ASSET_PATH + Item_Meta.get_image(item))
	$PriceTag.text = String(price)
	$QuantityTag.text = String(quantity)
	
func init(id, num, cost, icon_path):
	product_id = id
	quantity = num
	price = cost
	render_node()
	
func render_node():
	$PriceTag.text = String(price)
	$QuantityTag.text = String(quantity)
	$Button.icon = load(icon)

func _on_Button_pressed():
	emit_signal("pressed", product_id, price)
