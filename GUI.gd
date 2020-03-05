extends MarginContainer


onready var number_label = $Bars/LifeBar/Count/Background/Number
onready var bar = $HBoxContainer/Bars/HP_Bar/TextureProgress
onready var tween = $Tween

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("health_changed", self, "_on_Player_playerHealthChanged")
	var player_max_health = $"../Player".player_health
	bar.max_value = player_max_health
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_playerHealthChanged(player_health):
	print("received")
	bar.value = player_health
	pass # Replace with function body.
