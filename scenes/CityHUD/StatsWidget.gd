extends Panel

export var title = "title"
export (String) var number = 10000

func _ready():
	$Title.text = title+":"
	$Number.text = String(number)
