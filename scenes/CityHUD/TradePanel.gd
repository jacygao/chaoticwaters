extends Panel

signal buy(id, price)
signal sell(id, price)

func open_trade_panel():
	pass
	
func render_sell_container(products):
	$TradeGoodsContainer.render_products(products)
	
func render_buy_container(products):
	$TradeProductContainer.render_products(products)

func render_info_container():
	pass

func _on_TradeProductContainer_product_selected(pid, cost):
	var item = Item_Meta.get(pid)
	var image_url = Env.ITEM_ASSET_PATH + Item_Meta.get_image(item)
	var item_name = Item_Meta.get_item_name(item)
	#TODO: dynamically render quantity
	var item_quantity = 10
	$TradeInfoContainer.render_node(pid, image_url, item_name, cost, item_quantity, "BUY", Env.BUTTON_COLOR_GREEN)

func _on_TradeGoodsContainer_product_selected(pid, cost):
	var item = Item_Meta.get(pid)
	var image_url = Env.ITEM_ASSET_PATH + Item_Meta.get_image(item)
	var item_name = Item_Meta.get_item_name(item)
	#TODO: dynamically render quantity
	var item_quantity = 10
	$TradeInfoContainer.render_node(pid, image_url, item_name, cost, item_quantity, "SELL", Env.BUTTON_COLOR_BLUE)

func _on_TradeInfoContainer_deal(mode, id, price):
	if mode == "BUY":
		emit_signal("buy", id, price)
	if mode == "SELL":
		emit_signal("sell", id, price)
