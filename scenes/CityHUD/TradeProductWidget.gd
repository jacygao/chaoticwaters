extends Panel

export var product_id = "fish"

# Called when the node enters the scene tree for the first time.
func _ready():
	var item = Item_Meta.get(product_id)
	$Button.icon = load(Env.ITEM_ASSET_PATH + Item_Meta.get_image(item))
	$PriceTag.text = String(Item_Meta.get_value(item))

func init(id):
	product_id = id
