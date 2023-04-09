extends TextureRect

var m_name = ""
func set_quest(name):
	m_name = name
	$Label.text = name
	#print("Get %s "% str(name))
	#var mission = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_player().quests[name]
	#$ControlM.toggle_mission(name)
#по нажатию кнопки похожая движуха с задачами	
func _input(event):
	if $Button.pressed == true:
			get_parent().get_parent().get_parent().get_parent().get_parent().get_node("Name").text = m_name
			var ControlM = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("ControlM")
			ControlM.toggle_mission(m_name)
