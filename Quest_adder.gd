extends Node2D


#Первый квест
func quest_go_work():
	var a = "На работу"
	var b1 = "Поднимите пистолет"
	get_parent().get_player().get_quest(a)
	get_parent().get_player().get_quest_mission(a,b1)

func quest_go_work_do_m1():
	var a = "На работу"
	var b1 = "Поднимите пистолет"
	get_parent().get_player().do_quest_mission(a,b1)
