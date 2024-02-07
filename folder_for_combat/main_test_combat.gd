extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 1.2
	pass # Replace with function body.
func _physics_process(delta):
	GlobalForCombat.player_position = $player/things_for_flip/anim_sprite.global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
