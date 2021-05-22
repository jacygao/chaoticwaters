extends Node

"""
	The sel price is determined by the following aspects:
		If the product is locally produced
		City's economy value
		The boom value of the city
		
	Example:
		A product has a value of 1000 coins, not locally produced
		A city's ecomomy value is 2000, boom value 2
		the sold price = 1000 + 1000 * 20% * 2) = 1400 coins
		
	if the product is produced locally, the product value halves.
"""
func get_sell_price(product_value, economy, boom, is_local):
	if is_local:
		product_value = product_value / 2
		
	return product_value + product_value * economy / 10000 * boom
