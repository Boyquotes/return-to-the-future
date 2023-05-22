extends Node

var space_camera
var player_camera
var first_camera
var cur_camera = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	first_camera = get_node("/root/Main/SpaceShip/Model/Player/Model/character/Pivot/FirstCamera")
	space_camera = get_node("/root/Main/SpaceShip/Model/Pivot/SpaceCamera")
	player_camera = get_node("/root/Main/SpaceShip/Model/Player/Model/Pivot/PlayerCamera")
	first_camera.make_current()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_input(delta)
	pass

func process_input(delta):
	if Input.is_action_just_pressed("change_camera"):
		cur_camera = (cur_camera + 1) % 3
		if cur_camera == 0:
			first_camera.make_current()
		elif cur_camera == 1:
			space_camera.make_current()
		elif cur_camera == 2:
			player_camera.make_current()
