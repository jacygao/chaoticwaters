extends Panel

export var product_id = "fish"
export var price = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	var item = Item_Meta.get(product_id)
	print("debug")
	print(item)
	$Button.icon = load(Env.ITEM_ASSET_PATH + Item_Meta.get_image(item))
	$PriceTag.text = String(price)
	
