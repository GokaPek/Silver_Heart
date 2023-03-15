extends Area2D

var HP = 1;
var dead = false;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if dead == false:
		$AnimatedSprite.play("default");
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Enemy_area_entered(area):
	if area.is_in_group("Sword"):
		HP -= 1;
		if HP <= 0:
			dead = true;
			$AnimatedSprite.play("Destroyed");


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Destroyed":
		queue_free();
