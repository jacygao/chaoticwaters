extends Node

"""
	Singleton utility methods for reuse.
"""

func tutorial_position_offset(node):
	var pos = node.get_position()
	var size = node.get_size()
	var scale = node.get_scale()
	
	pos.x = pos.x + size.x/2 * scale.x + 40
	pos.y = pos.y + size.y/2 * scale.y + 40
	return pos
