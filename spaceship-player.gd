extends CharacterBody3D

@export var max_ahead_acce = 5.0
@export var max_ahead_dece = -20.0
@export var max_ahead_speed = 10.0

var a_front = - max_ahead_acce / max_ahead_speed
var b_front = max_ahead_acce
var cur_ahead_speed = 0.0

@export var dir_acce = 2.0
@export var dir_dece = 2.0
@export var max_dir_speed = 10.0

func _ready():
	pass

func _physics_process(delta):
	process_input(delta)
	process_movement(delta)

func process_input(delta):
	var delta_cur_ahead_speed = 0.0
	if Input.is_action_pressed("add_speed"):
		delta_cur_ahead_speed = delta * cal_acce(a_front, b_front, cur_ahead_speed)
	if Input.is_action_pressed("sub_speed"):
		if delta_cur_ahead_speed > 0.0:
			delta_cur_ahead_speed = 0.0
		else:
			delta_cur_ahead_speed = delta * max_ahead_dece
	cur_ahead_speed = maxf(cur_ahead_speed + delta_cur_ahead_speed, 0.0)
	print(cur_ahead_speed)

func process_movement(delta):
	velocity.x = cur_ahead_speed
	move_and_slide()

func cal_acce(a, b, speed) -> float:
	return a * speed + b
