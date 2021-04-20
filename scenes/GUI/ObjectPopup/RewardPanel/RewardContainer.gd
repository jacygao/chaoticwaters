extends Container

export var item_name = "rifle"
export var amount = 100

var asset_path = Env.ITEM_ASSET_PATH

# Called when the node enters the scene tree for the first time.
func _ready():
	render_node()

# nam - setting the name of the item to be loaded from Item metadata.
# num - setting the amount of the item to be displayed.
# count - sequential number of the order of the item to be rendered.
func init_node(nam, num, count):
	item_name = nam
	amount = num
	rect_position.x = rect_size.x * (count-1)
	
	render_node()
	
func render_node():
	var item = Item_Meta.get(item_name)
	$Sprite.texture = load(asset_path + Item_Meta.get_image(item))
	$Label.text = String(amount)
