extends Node

"""
Implementation of a simple Dialog Recorder that stores played dialogs.
"""

var dialog = {}

func has_played(key):
	if dialog.has(key):
		return true
	return false

func save(key):
	dialog[key] = true
