extends Area2D


var active = false
var amount = 1

#система исчезновения и подбора
func _ready():
	if 'is_tacked_gun' in get_parent().get_parent().get_player().bool_var.keys():
		queue_free()
	connect("body_entered", self, '_on_NPC_body_entered')
	connect("body_exited", self, '_on_NPC_body_exited')


#func _process(delta):
#	$SpritePDA.visible = active
	
func _input(event):
	if ( event.is_action_pressed("e_click") or $Button.pressed) and active:
		var pl = get_parent().get_parent().get_player()
		pl.set_bool('is_tacked_gun', true)
		#$Sprite.visible = false
		#$Button.visible = false
		pl.pick(self)
		get_parent().get_parent().get_node("Gloss_adder").about_gun()
		get_parent().get_parent().get_node("Quest_adder").quest_go_work_do_m1()
		queue_free()


func _on_NPC_body_entered(body):
	if body.name == "Player":
		active = true
		
func _on_NPC_body_exited(body):
	if body.name == "Player":
		active = false

#система инвентаря
func get_amount():
	return amount
