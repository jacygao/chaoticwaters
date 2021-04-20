extends Node2D

var reward_items = []
var reward_node = null

signal claim_all(items)

func open(node):
	reward_node = node
	reward_items = node.get_items()
	
	$ObjectPopupPanel/RewardPanel.init_node(reward_items)
	$ObjectPopupPanel.popup()

func close():
	$ObjectPopupPanel.hide()

func _on_RewardPanel_claim_all_pressed():
	reward_node.clear_node()
	emit_signal("claim_all", reward_items)
	close()

func show_tutorial():
	$ObjectPopupPanel/TutorialUI.open()
	
func hide_tutorial():
	$ObjectPopupPanel/TutorialUI.close()
