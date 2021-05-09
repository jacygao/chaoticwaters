extends Panel

enum {BUY, SELL}

export var product_id = "fish"
export var quantity = 10
export var mode = BUY
export var price = 0

signal pressed(pid, cost)

# Called when the node enters the scene tree for the first time.
func _ready():
	var item = Item_Meta.get(product_id)
	price = Item_Meta.get_value(item)
	$Button.icon = load(Env.ITEM_ASSET_PATH + Item_Meta.get_image(item))
	$PriceTag.text = String(price)
	$QuantityTag.text = String(quantity)
	
func init(id):
	product_id = id

func render_node():
	$PriceTag.text = String(price)
	$QuantityTag.text = String(quantity)

func _on_Button_pressed():
	if quantity > 0:
		quantity-=1
		emit_signal("pressed", product_id, price)
		render_node()
