extends Panel

signal claim_all_pressed

var reward_container = preload("res://scenes/GUI/ObjectPopup/RewardPanel/RewardContainer.tscn")
var limit = 3

# passing an array of items when openning a new reward popup
# limit of 3 items until resizing is implemented
# TODO: supporting more items
# items - an array of item
# item - must contain a name in the Item_Mata and the amount
func init_node(items):
	var count = 0
	for item in items:
		count+=1
		if count > limit:
			break
		var reward = reward_container.instance()
		reward.init_node(item["name"], item["amount"], count)
		add_child(reward)

func _on_ObjectPopupButton_pressed():
	emit_signal("claim_all_pressed")
