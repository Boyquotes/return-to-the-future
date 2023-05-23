extends Node3D

@export var amount = 4
@export var interval = 200.0
@export var fresh_distance = 50.0
var spaceship
var spaceship_collider
var circles
var circle_pool = []
const Circle = preload("res://circle.tscn")

func _ready():
	spaceship = get_node("/root/Main/SpaceShip")
	spaceship_collider = spaceship.get_node("Collider")
	circles = get_node("/root/Main/CircleProductor/Circles")
	for i in range(0, amount):
		var c = Circle.instantiate()
		c.position.x = spaceship.position.x + i * interval
		circle_pool.append(c)
		c.body_entered.connect(_on_circle_ship_body_entered)
		circles.add_child(c)

func _on_circle_ship_body_entered(body):
	circle_pool[0].position.x = circle_pool[-1].position.x + interval
	circle_pool.append(circle_pool.pop_front())

func _process(delta):
	pass
