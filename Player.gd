extends KinematicBody2D

var MAX_SPEED = 200
var ACC = 700
var motion = Vector2.ZERO
var canShoot = true
signal playerHealthChanged 

var player_health = 100
var player_mana = 100

var timeToShoot = Timer.new()

var shotInterval = .3


export var bullet : PackedScene

func _ready():
	timeToShoot.connect("timeout", self, "_on_timeToShoot_ready")
	emit_signal("health_changed", player_health)
	add_child(timeToShoot)
	
	
func _on_timeToShoot_ready():
	canShoot = true

func _physics_process(delta):
	var axis = GetInputAxis()
	if(axis == Vector2.ZERO):
		ApplyFriction(ACC * delta)
	else:
		ApplyMotion(axis * ACC * delta)
		
	motion = move_and_slide(motion)
	
	if(Input.is_action_pressed("ui_fire")):
#		if(hasShot == false):
		if(canShoot):
			FireProjectile()
			timeToShoot.start(shotInterval)
			canShoot = false
	
	
func GetInputAxis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed(("ui_up")))
	
	return axis.normalized()
	
func ApplyFriction(amount):
	if (motion.length() > amount):
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO
		
func ApplyMotion(acceleration):
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)
	
func FireProjectile():
	var new_bullet = bullet.instance()
	new_bullet.initialize((get_global_mouse_position() - global_position).normalized())
	
	add_child(new_bullet)
	new_bullet.global_position = global_position
	new_bullet.look_at(get_global_mouse_position())
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
