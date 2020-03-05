extends Node2D

var direction : Vector2
export var move_speed = 50


func initialize(_direction):
	direction = _direction
	
	
func _process(delta):
	position += direction * move_speed * delta



# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)
	pass # Replace with function body.


