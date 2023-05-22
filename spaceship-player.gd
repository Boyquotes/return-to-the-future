extends CharacterBody3D

# move ahead data
@export var max_ahead_acce = 20.0
@export var max_ahead_dece = -40.0
@export var max_ahead_speed = 30.0

var a_front = - max_ahead_acce / max_ahead_speed
var b_front = max_ahead_acce
var cur_ahead_speed = 0.0

# move dir data
@export var max_dir_acce = 20.0
@export var max_dir_dece = 5.0
@export var max_dir_speed = 10.0
@export var dir_error = 0.02

var a_dir = - max_dir_acce / max_dir_speed
var b_dir = max_dir_acce
var cur_horizontal_speed = 0.0
var cur_vertical_speed = 0.0


func _ready():
	pass

func _physics_process(delta):
	process_input(delta)
	process_movement(delta)

func process_input(delta):
	process_ahead_input(delta)
	cur_horizontal_speed = process_dir_input(delta, Input.is_action_pressed("move_right"),
		Input.is_action_pressed("move_left"), cur_horizontal_speed)
	cur_vertical_speed = process_dir_input(delta, Input.is_action_pressed("move_up"),
		Input.is_action_pressed("move_down"), cur_vertical_speed)

func process_movement(delta):
	velocity.x = cur_ahead_speed
	velocity.y = cur_vertical_speed
	velocity.z = cur_horizontal_speed
	move_and_slide()

func process_ahead_input(delta):
	var delta_cur_ahead_speed = 0.0
	if Input.is_action_pressed("add_speed"):
		delta_cur_ahead_speed = delta * cal_acce(a_front, b_front, cur_ahead_speed)
	if Input.is_action_pressed("sub_speed"):
		if delta_cur_ahead_speed > 0.0:
			delta_cur_ahead_speed = 0.0
		else:
			delta_cur_ahead_speed = delta * max_ahead_dece
	cur_ahead_speed = maxf(cur_ahead_speed + delta_cur_ahead_speed, 0.0)
	
func process_dir_input(delta, positive, negative, cur_speed) -> float:
	var move_flag = 0
	var delta_cur_dir_speed = 0.0
	if positive:
		move_flag = 1
	if negative:
		if move_flag == 1:
			move_flag = 0
		else:
			move_flag = -1
	if move_flag != 0:
		delta_cur_dir_speed = move_flag * delta * cal_acce(a_dir, b_dir, absf(cur_speed))
	if cur_speed > 0.0:
		delta_cur_dir_speed -= delta * max_dir_dece
	elif cur_speed < 0.0:
		delta_cur_dir_speed += delta * max_dir_dece
	cur_speed += delta_cur_dir_speed
	if absf(cur_speed) < dir_error:
		cur_speed = 0.0
	return cur_speed

func cal_acce(a, b, speed) -> float:
	return a * speed + b
