extends Node

"""
Implementation of a simple Economy System that manages player economy.
"""

var economy = {
	"coins": 10000,
	"wood": 0,
	"stone": 0,
	"gem": 0,
}

func get_coins():
	return economy["coins"]

func set_coins(val):
	economy["coins"] = val

func is_insufficient(amount):
	return amount <= get_coins()

func deduct_coins(amount):
	if !is_insufficient(amount):
		return false
	var new_coins = get_coins() - amount
	set_coins(new_coins)
	return true

func add_coins(amount):
	var new_coins = get_coins() + amount
	set_coins(new_coins)
	return true
