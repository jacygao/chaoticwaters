extends Panel

export var level = 0
export var max_level = 0
export var effect = "Effect + 100"
export var cost = 1000
export var time = 600

# Called when the node enters the scene tree for the first time.
func _ready():
	render_node()

func set_cur_level(lvl):
	level = lvl

func set_max_level(lvl):
	max_level = lvl

func set_effect(desc):
	effect = desc
	
func set_cost(val):
	cost = val

func set_cost_sufficient():
	$Cost.self_modulate = Color(1, 1, 0)
	
func set_cost_insufficient():
	$Cost.self_modulate = Color(1, 0, 0)
	
func set_research_time(t):
	time = t

func render_node():
	if level >= max_level:
		$Level.text = "Max Level Reached"
		$Effect.text = ""
		$Cost.text = ""
		$Time.text = ""
	else:
		$Level.text = get_level_str()
		$Effect.text = effect
		$Cost.text = "Cost: " + String(cost)
		$Time.text = "Research Time: " + get_time_str(time)
	
func get_level_str():
	return "Level "+ String(level) + " - Level "+ String(level+1)
	
func get_time_str(secs):
	if secs == 0:
		return "0 second"
	if secs == 1:
		return "1 second"
	if secs < 60:
		return String(secs) + " seconds"
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
