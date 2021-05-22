extends Node

var city = {
	"Stockholm": {
		"population": 134000,
		"economy": 1880,
		"defence": 2000,
		"boom": 2,
		"products": {
			"fish":2, 
			"bread":2, 
			"weapon":1, 
			"bronze":1,
		},
		"places": {
			"palace": true,
			"bar": true,
			"merchant": true,
			"hotel": true,
			"shipyard": true,
			"port": true,
		},
		"forces": {
			"Leo Linderroth": 30,
		}
	},
	"Riga": {
		"population": 96200,
		"economy": 1020,
		"defence": 800,
		"boom": 2,
		"products": {
			"grain":2, 
			"fur":1,
			"wax":1,
		},
		"places": {
			"palace": true,
			"bar": true,
			"merchant": true,
			"hotel": true,
			"shipyard": false,
			"port": true,
		},
		"forces": {
			"Leo Linderroth": 20,
		}
	}
}

func occupy(city_name, force_name, rate):
	var c = city[city_name]
	if !c["forces"].has(force_name):
		c["forces"][force_name] = 0
	c["forces"][force_name] += rate

func get_city(city_name:String):
	return city[city_name]

func get_population(city_name:String):
	return city[city_name]["population"]

func get_economy(city_name:String):
	return city[city_name]["economy"]
	
func get_defence(city_name:String):
	return city[city_name]["defence"]

func get_boom(city_name:String):
	return city[city_name]["boom"]

func get_forces(city_name:String):
	return city[city_name]["forces"]

func get_products(city_name:String):
	return city[city_name]["products"]

func has_product(city_name:String, product_name:String):
	return city[city_name]["products"].has(product_name)

func get_places(city_name:String):
	return city[city_name]["places"]

func sold_product(city_name, pid):
	if city[city_name]["products"][pid] > 0:
		city[city_name]["products"][pid] -= 1
		return true
	return false
