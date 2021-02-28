extends CanvasLayer

var coins = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	update_coins(coins)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_coins(coins):
	$Panel/Number.text = String(coins)
