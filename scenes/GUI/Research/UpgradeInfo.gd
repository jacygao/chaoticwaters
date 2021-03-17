extends Panel

export var level = 0
export var effect = "Effect + 100"
export var cost = 1000
export var time = 600

# Called when the node enters the scene tree for the first time.
func _ready():
	render_text()

func set_cur_level(lvl):
	level = lvl
	
func set_effect(desc):
	effect = desc

func set_cost(val):
	cost = val
	
func set_research_time(t):
	time = t

func render_text():
	$Level.text = "Level "+ String(level) + " - Level "+ String(level+1)
	$Effect.text = effect
	$Cost.text = "Cost: " + String(cost)
	$Time.text = "Research Time: " + get_time_str(time)
	
func get_time_str(secs):
	if secs == 1:
		return "1 second"
	if secs < 60:
		return secs + " seconds"
	if secs < 3600:
		var mm = secs / 60
		var time_str = String(mm) + " minutes"
		var ss = secs % 60
		if ss > 0:
			time_str = time_str + " " + String(ss) + " seconds"
		return time_str
	if secs > 3600:
		var hh = secs / 3600
		var time_str = String(hh) + " hours"
		var mm = secs % 3600 / 60
		if mm > 0:
			time_str = time_str + " " + String(mm) + " minutes"
		var ss = secs % 3600 % 60
		if ss > 0:
			time_str = time_str + " "+ String(ss) + " seconds"
		return time_str
