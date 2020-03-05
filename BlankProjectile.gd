extends KinematicBody2D

var direction : Vector2
export var move_speed = 1000


func initialize(_direction):
	direction = _direction
	
	
func _process(delta):
	var collision = move_and_collide( direction * move_speed * delta)
	if(collision != null):
		self.queue_free()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)
	pass # Replace with function body.
