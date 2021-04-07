class_name Boat
extends KinematicBody2D

export var default_speed = 0
var speed = default_speed

# How fast boat turns
export (float) var default_rotation_speed = 0
var rotation_speed = default_rotation_speed

# The default health
export var max_durability = 10
var durability = max_durability

# The strength of the fire
export var fire_damage = 1
# The range of the fire

export var fire_max_range = 300

var isAnchorOn = false

var smoke = preload("res://scenes/Boat/Smoke.tscn")
var cannon_ball = preload("res://scenes/CannonBall/CannonBall.tscn")

# navigation control variables
var cur_rotation = 0
var rotation_dir = 0
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# ensures the angle is netween -179 and 180 degrees
func angle_tidy(a):
	if a > 180:
		a = (360 - a) * -1
	if a < -180:
		a = 360 - a * -1
	return a

func anchor_on():
	speed = 0
	rotation_speed = 0
	isAnchorOn = true
	
func anchor_off():
	rotation_speed = default_rotation_speed
	isAnchorOn = false

func navigate():
	pass

func display_health():
	pass
	
func fire():
	pass
	
func repair():
	pass
	
func damage():
	pass
