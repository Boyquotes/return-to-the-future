extends Camera3D

@export var camera_speed = 0.05
@export var up_view = 10.0
@export var down_view = 40.0
@export var left_view = 10.0
@export var right_view = 40.0
var rot_x = 0.0
var rot_y = 0.0
var pivot

# Called when the node enters the scene tree for the first time.
func _ready():
	pivot = get_parent()
	up_view = deg_to_rad(up_view)
	down_view = deg_to_rad(down_view)
	left_view = deg_to_rad(left_view)
	right_view = deg_to_rad(right_view)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseMotion and current:
		rot_x -= deg_to_rad(event.relative.x * camera_speed)
		rot_y -= deg_to_rad(event.relative.y * camera_speed)
		rot_x = clampf(rot_x, -right_view, left_view)
		rot_y = clampf(rot_y, -down_view, up_view)
		pivot.transform.basis = Basis()
		pivot.rotate_object_local(Vector3(0, 1, 0), rot_x)
		pivot.rotate_object_local(Vector3(0, 0, 1), rot_y)
