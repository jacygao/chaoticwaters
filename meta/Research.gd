extends Node

"""
	This script currently stores metadata for Research. 
	It should eventually be moved to a remote server.
	Metadata will be loaded when game starts up.
	TODO: Consider creating separate meta data dictionaries for better scalability.
"""

var meta = {
	"cannon": {
		"max_level": 3,
		"level": {
			1: {
				"upgrade_cost": 100,
				"boost": {
					"damage": 1,
				},
				"research_time": 2,
			},
			2: {
				"upgrade_cost": 200,
				"boost": {
					"damage": 2,
				},
				"research_time": 4,
			},
			3: {
				"upgrade_cost": 400,
				"boost": {
					"damage": 4,
				},
				"research_time": 8,
			},
		},
	},
	"spyglass": {
		"max_level": 3,
		"level": {
			1: {
				"upgrade_cost": 50,
				"boost": {
					"visibility": 1,
				},
				"research_time": 1,
			},
			2: {
				"upgrade_cost": 100,
				"boost": {
					"visibility": 2,
				},
				"research_time": 2,
			},
			3: {
				"upgrade_cost": 200,
				"boost": {
					"visibility": 4,
				},
				"research_time": 4,
			},
		},
	},
	"sail": {
		"max_level": 3,
		"level": {
			1: {
				"upgrade_cost": 200,
				"boost": {
					"speed": 1,
				},
				"research_time": 4,
			},
			2: {
				"upgrade_cost": 400,
				"boost": {
					"speed": 2,
				},
				"research_time": 8,
			},
			3: {
				"upgrade_cost": 800,
				"boost": {
					"speed": 4,
				},
				"research_time": 16,
			},
		},
	},
	"deck": {
		"max_level": 3,
		"level": {
			1: {
				"upgrade_cost": 100,
				"boost": {
					"armor": 1,
				},
				"research_time": 2,
			},
			2: {
				"upgrade_cost": 100,
				"boost": {
					"armor": 2,
				},
				"research_time": 4,
			},
			3: {
				"upgrade_cost": 200,
				"boost": {
					"armor": 4,
				},
				"research_time": 8,
			},
		},
	},
}

func get_meta(key):
	if !meta.has(key):
		return {}
		
	return meta[key]

func get_meta_level(key, level):
	if !meta.has(key):
		return {}
	
	if !can_upgrade(key, level):
		return {}

	return meta[key]["level"][level]

func get_meta_max_level(key):
	if !meta.has(key):
		return 0
	return meta[key]["max_level"]
	
func can_upgrade(key, level):
	if !meta.has(key):
		return false
		
	if level <= meta[key]["max_level"]:
		return true
		
	return false

func get_boost_st(boost):
	var boost_str = ""
	var counter = 0
	for k in boost:
		if counter == 0:
			boost_str += ("%s +%d" % [k, boost[k]])
		else:
			boost_str += (", %s +%d" % [k, boost[k]])
		counter+=1
	return 	boost_str.capitalize()
