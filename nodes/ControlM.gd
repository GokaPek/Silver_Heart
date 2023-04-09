extends Control

var is_displaing = false;

func toggle_mission(name):
	var quest = get_parent().get_parent().get_parent().get_parent().get_parent().get_player().quests
	$PanelM.visible = true
	if is_displaing:
		$PanelM.clear()
		is_displaing = false
	else:
		$PanelM.clear()
		is_displaing = true
	$PanelM.show_mission(quest,name)
	
#функция возможно будет использована после
#func update_mission(name):
#	var quest = get_parent().get_parent().get_parent().get_parent().get_parent().get_player().quests
#	if $PanelM.visible:
#		$PanelM.show_mission(quest, name)
