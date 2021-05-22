extends Container

var product_widget = preload("res://scenes/CityHUD/TradeProductWidget.tscn")
var products = {}
export var mode = "SELL"
export var city_id = "Stockholm"

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
		node.init(
			product,
			ps[product],
			get_price(product),
			Env.ITEM_ASSET_PATH + Item_Meta.get_item_image(product))
		node.set_position(Vector2(count*(margin+node.rect_size.x), 0))
		node.connect("pressed", self, "_on_product_pressed")
		add_child(node)
		count+=1

func _on_product_pressed(pid, cost):
	emit_signal("product_selected", pid, cost)

func get_price(product_id):
	if mode == "SELL":
		return get_sell_price(product_id)
	elif mode == "BUY":
		return get_buy_price(product_id)
		
	return Item_Meta.get_item_value(product_id)
	
"""
	The buy & sell prices are determined by the following aspects:
		If the product is locally produced
		City's economy value
		The boom value of the city
		
	Example:
		A product has a value of 1000 coins, not locally produced
		A city's ecomomy value is 2000, boom value 2
		the sold price = 1000 + 1000 * 20% * 2) = 1400 coins
		
	if the product is produced locally, the product value halves.
"""
func get_sell_price(product_id):
	var product_value = Item_Meta.get_item_value(product_id)
	if City.has_product(city_id, product_id):
		print("local product: ", product_id)
		product_value = product_value / 4
		
	return product_value + product_value * City.get_economy(city_id) / 10000 * City.get_boom(city_id)

func get_buy_price(product_id):
	var product_value = Item_Meta.get_item_value(product_id)
	return product_value - product_value * City.get_economy(city_id) / 10000 * City.get_boom(city_id)

# TODO: implement
func is_product_local():
	return false
