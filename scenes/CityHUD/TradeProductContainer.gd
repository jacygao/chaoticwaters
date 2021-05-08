extends Container

var product_widget = preload("res://scenes/CityHUD/TradeProductWidget.tscn")
var products = ["fish", "bread", "weapon", "bronze"]
# Called when the node enters the scene tree for the first time.
func _ready():
	render_products()

# example of products: ["fish", "bread"]
func render_products():
	var count = 0
	var margin = 20
	for product in products:
		var node = product_widget.instance()
		node.product_id = product
		node.set_position(Vector2(count*(margin+node.rect_size.x), 0))
		add_child(node)
		count+=1
