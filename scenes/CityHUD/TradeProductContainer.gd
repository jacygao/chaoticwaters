extends Container

var product_widget = preload("res://scenes/CityHUD/TradeProductWidget.tscn")
var products = {}

signal product_selected(pid, cost)

# Called when the node enters the scene tree for the first time.
func _ready():
	render_products(products)

func set_products(ps):
	products = ps

# example of products: {"fish":1, "bread":2}
func render_products(ps:Dictionary):
	for child in get_children():
		child.queue_free()
		
	set_products(ps)
	
	var count = 0
	var margin = 20
	for product in ps.keys():
		var node = product_widget.instance()
		node.product_id = product
		node.quantity = ps[product]
		node.set_position(Vector2(count*(margin+node.rect_size.x), 0))
		node.connect("pressed", self, "_on_product_pressed")
		add_child(node)
		count+=1

func _on_product_pressed(pid, cost):
	emit_signal("product_selected", pid, cost)
