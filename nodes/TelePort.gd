extends Area2D

var active = false

func _ready():
	connect("body_entered", self, '_on_NPC_body_entered')
	connect("body_exited", self, '_on_NPC_body_exited')

func _input(event):
	if (event.is_action_pressed("e_click") and active):
		get_tree().change_scene("res://nodes/locations/street_home_2_1.tscn")


func _on_NPC_body_entered(body):
	if body.name == "Player":
		active = true
func _on_NPC_body_exited(body):
	if body.name == "Player":
		active = false
