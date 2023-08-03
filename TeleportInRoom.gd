extends Area2D

var active = false

func _ready():
	connect("body_entered", self, '_on_NPC_body_entered')
	connect("body_exited", self, '_on_NPC_body_exited')

func _input(event):
	if (event.is_action_pressed("e_click") and active):
		var stats = ConfigFile.new()
		var player = get_parent().get_parent().get_player()
		#задел на характеристики персонажа
		stats.set_value("Player", "vision_lvl", player.vision_lvl)
		#система предметов
		stats.set_value("Player", "inventory", player.inventory)
		#система глоссария
		stats.set_value("Player", "gloss", player.gloss)
		stats.set_value("Player", "gloss_world", player.gloss_world)
		stats.set_value("Player", "gloss_persons", player.gloss_persons)
		#система квестов
		stats.set_value("Player", "quests", player.quests)
		stats.set_value("Player", "complited_quests", player.complited_quests)
		#деньги
		stats.set_value("Player", "money", player.money)
		
		get_tree().change_scene("res://nodes/locations/home.tscn")
		stats.save("user://stats.cfg")

func _on_NPC_body_entered(body):
	if body.name == "Player":
		active = true
func _on_NPC_body_exited(body):
	if body.name == "Player":
		active = false
