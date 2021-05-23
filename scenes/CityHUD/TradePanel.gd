extends Panel

signal buy(id, price)
signal sell(id, price)
signal sell_all
signal confirm

export var city_id = "Stockholm"

var sell_products = {}
var buy_products = {}

func _ready():
	$TradeInfoContainer.visible = false
	render_node()

func render_node():
	$TradeGoodsContainer.city_id = city_id

func set_city_id(c_id):
	city_id = c_id
	render_node()

# products are in a form of key-value pairs with 
# key represneting the product id and 
# value representing the quantity of the items
# for example
# {"item_1": 2, "item_2": 3}
func render_sell_container(products:Dictionary):
	sell_products = products
	$TradeGoodsContainer.render_products(products)
	
func render_buy_container(products:Dictionary):
	buy_products = products
	$TradeProductContainer.render_products(products)

func _on_TradeProductContainer_product_selected(pid, cost):
	if !$TradeInfoContainer.visible:
		$TradeInfoContainer.visible = true
		
	var item = Item_Meta.get(pid)
	var image_url = Env.ITEM_ASSET_PATH + Item_Meta.get_image(item)
	var item_name = Item_Meta.get_item_name(item)
	var item_quantity = buy_products[pid]
	$TradeInfoContainer.render_node(pid, image_url, item_name, cost, item_quantity, "BUY", Env.BUTTON_COLOR_GREEN)

func _on_TradeGoodsContainer_product_selected(pid, cost):
	if !$TradeInfoContainer.visible:
		$TradeInfoContainer.visible = true
		
	var item = Item_Meta.get(pid)
	var image_url = Env.ITEM_ASSET_PATH + Item_Meta.get_image(item)
	var item_name = Item_Meta.get_item_name(item)
	var item_quantity = sell_products[pid]
	$TradeInfoContainer.render_node(pid, image_url, item_name, cost, item_quantity, "SELL", Env.BUTTON_COLOR_BLUE)

func _on_TradeInfoContainer_deal(mode, id, price):
	if mode == "BUY":
		emit_signal("buy", id, price)
	if mode == "SELL":
		emit_signal("sell", id, price)
		
	$TradeInfoContainer.render_quantity($TradeInfoContainer.node_quantity-1)

func _on_SellAllButton_pressed():
	emit_signal("sell_all")

func _on_LeaveButton_pressed():
	emit_signal("confirm")
