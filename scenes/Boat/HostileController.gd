extends Node

"""
	hostile stores a dictionary of hostile nodes.
	
	A hostile node includes:
	 - key indentifier of a node object
	 - A pointer object to the node object itself 
	
	Any node becomes hostile when:
	- Player triggers an attack
	- Player is attacked by
	
	Any node is removed from hostile when:
	- Certain distance reaches between a hostile node and player node
"""
var hostile = {}

func has(node_id:String):
	return hostile.has(node_id)

func append(node):
	if !node.has_method("id"):
		return false
	Logger.INFO("hostile node appended: " + node.id())
	hostile[node.id()] = node
	return true

func remove(id:String):
	if has(id):
		hostile.erase(id)
