extends Node2D

# Declare member variables here. Examples:
export var fire_range = 500
export var fire_damage = 5
export (float) var default_rotation_speed = 1
export var team = 1
var rotation_speed = default_rotation_speed

var cur_rotation
var targets = {}
var target = null
var cannon_ball = preload("res://scenes/CannonBall/CannonBall.tscn")

signal city_entered
signal city_exited

# Called when the node enters the scene tree for the first time.
func _ready():
	$Outpost/FireRange.shape.radius = fire_range
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !targets.empty():
		target = targets.values().front()
		$Cannon.rotation = (target.position - position).angle()
		
func type():
	return "city"

func team():
	return team

func _on_Outpost_body_entered(body):
	if body.has_method("type"):
		if body.type() == "ship":
			if body.team() != team():
				targets[body.id()] = body
			
func _on_Outpost_body_exited(body):
	if body.has_method("type"):
		if body.type() == "ship": 
			if body.team() != team():
				targets.erase(body.id())

func _on_CannonGun_fire(vec):
	if vec.has_method("team") && vec.team() == team:
		return
		
	if vec.has_method("type") && vec.type() == "ship":
		fire_animate(vec.position - position)

# Fires an animated cannon ball at a given vector position
func fire_animate(vec):
	var cannon_ball_ins = cannon_ball.instance()
	var angle = vec.angle()
	cannon_ball_ins.position = $Cannon/CannonGunAngle.get_global_position()
	cannon_ball_ins.init(angle, fire_damage, fire_range)
	$Cannon/CannonGunFireSmoke.set_emitting(true)
	get_parent().add_child(cannon_ball_ins)


func _on_Dock_body_entered(body):
	if body.has_method("type"):
		if body.type() == "ship" && body.team() == team():
			emit_signal("city_entered")

func _on_Dock_body_exited(body):
	if body.has_method("type"):
		if body.type() == "ship" && body.team() == team():
			emit_signal("city_exited")
