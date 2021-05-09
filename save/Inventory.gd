extends Node

"""
	Inventory stores a list of items with key as the name of the item and value as the amount.
"""

var inventory = {}

# store takes an array of items.
# each item must be in a key value format with 
# key being the name of the item and value as the amount.
# Sample item data: {"name": "rifle", "amount": 2}
func store(items):
	for item in items:
		store_one(item)

func store_one(item):
	print("storing item: ", item)
	if !inventory.has(item["name"]):
			inventory[item["name"]] = 0
	inventory[item["name"]] += item["amount"]

func get_all():
	return inventory
