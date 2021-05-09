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

func store_one_id(id):
	store_one({"name": id, "amount": 1})

func store_one(item):
	print("storing item: ", item)
	if !inventory.has(item["name"]):
			inventory[item["name"]] = 0
	inventory[item["name"]] += item["amount"]
	
func remove_one_id(id):
	if !inventory.has(id):
		print("[WARN] id does not exist!")
		return
	if inventory[id] == 0:
		print("[WARN] id has insufficient amount ", inventory[id])
		return
	if inventory[id] == 1:
		inventory.erase(id)
		return
	inventory[id] -= 1
	
func get_all():
	print("retrieving inventory: ", inventory)
	return inventory
