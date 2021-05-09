extends Container

var product_widget = preload("res://scenes/CityHUD/TradeProductWidget.tscn")
var products = ["fish", "bread", "weapon", "bronze"]

signal product_selected(pid, cost)

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
		node.connect("pressed", self, "_on_product_pressed")
		add_child(node)
		count+=1

func _on_product_pressed(pid, cost):
	emit_signal("product_selected", pid, cost)
