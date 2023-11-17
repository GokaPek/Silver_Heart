extends Control

func _on_Button_pressed():
	var stats = ConfigFile.new()
	#задел на характеристики персонажа
	stats.set_value("Player", "vision_lvl", 0)
	#система предметов
	stats.set_value("Player", "inventory", {})
	#система глоссария
	stats.set_value("Player", "gloss", {})
	stats.set_value("Player", "gloss_world", {})
	stats.set_value("Player", "gloss_persons", {})
	#система квестов
	stats.set_value("Player", "quests", {})
	stats.set_value("Player", "complited_quests", {})
	#логические переменные
	stats.set_value("Player", "bool_var", {})
	#деньги
	stats.set_value("Player", "money", 0)
	stats.save("user://stats.cfg")
	get_tree().change_scene("res://nodes/locations/home.tscn")
