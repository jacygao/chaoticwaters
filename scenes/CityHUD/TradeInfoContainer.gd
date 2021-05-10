extends Panel

export var node_id = "fish"
export var node_image = "res://assets/gui/icon.png"
export var node_p_name = "Fish"
export var node_cost = 100
export var node_quantity = 10

export var button_text = "BUY"
export (Color) var button_color = Env.BUTTON_COLOR_BLUE

signal deal(mode, id, price)

func _ready():
	render_node(
		node_id, 
		node_image, 
		node_p_name,
		node_cost, 
		node_quantity, 
		button_text, 
		button_color
	)

func set_val(p_id, image, p_name, cost, quantity, btn_text, btn_color:Color):
	node_id = p_id
	node_image = image
	node_p_name = p_name
	node_cost = cost
	node_quantity = quantity
	button_text = btn_text
	button_color = btn_color

func render_node(p_id, image, p_name, cost, quantity, btn_text, btn_color:Color):
	set_val(p_id, image, p_name, cost, quantity, btn_text, btn_color)
	
	render_button(btn_text, btn_color)
	$Sprite.texture = load(image)
	$Container/ProductName.text = "Product: "+p_name
	$Container/ProductCost.text = "Price: "+String(cost)
	render_quantity(quantity)
	
func render_button(text, color:Color):
	$ObjectPopupButton.set_text(text)
	$ObjectPopupButton.set_color(color)
	$ObjectPopupButton.render_node()

func render_quantity(num):
	node_quantity = num
	$Container/ProductQuantity.text = "Stock: "+String(node_quantity)

func _on_ObjectPopupButton_pressed():
	if node_quantity > 0:
		emit_signal("deal", button_text, node_id, node_cost)
