extends Node2D


#Первый квест
func quest_go_work():
	var a = "На работу"
	var b1 = "Поднимите пистолет"
	get_parent().get_player().get_quest(a)
	get_parent().get_player().get_quest_mission(a,b1)
	#
	get_parent().get_player().get_quest("Покакай")
	get_parent().get_player().get_quest_mission("Покакай","Посикай")
	get_parent().get_player().get_quest_mission("Покакай","Попукай")
	get_parent().get_player().get_quest_mission("Покакай","Сика")
	get_parent().get_player().get_quest_mission("Покакай","Лика")
	get_parent().get_player().get_quest("Апельсин")
	get_parent().get_player().get_quest_mission("Апельсин","Мандарин")
	
func quest_go_work_do_m1():
	var a = "На работу"
	var b1 = "Поднимите пистолет"
	get_parent().get_player().do_quest_mission(a,b1)
