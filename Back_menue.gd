extends Node2D



func _ready():
	pass 


var back_menue_bool = false
func _input(event):
	if event.is_action_pressed("back_i_click") or ($Interface/Button.pressed):
		if(get_parent().get_node("CameraLoc").current == true):
			position.x = 0
			position.y = 0
			#абсолютно то же самое, что и в Esc_menue
			if back_menue_bool == false and (get_tree().paused == false):
				$Interface.visible = true
				var quests = get_parent().get_player().quests
				$Interface/Missions.visible = true
				$Interface/Missions/UIQuests/ControlQ.toggle_quest(quests)
				$Interface/Missions/UIQuests.visible = true
				#
				get_tree().paused = true
				back_menue_bool = true
				return
			if back_menue_bool == true:
				$Interface/Missions.visible = false
				$Interface/Inventory.visible = false
				$Interface/Map.visible = false
				$Interface/Gloss.visible = false
				$Interface/Last.visible = false
				$Interface.visible = false
				$Interface/Inventory/UInventory/Control/Panel.visible = false
				$Interface/Gloss/UIgloss/ControlGloss/PanelGloss.visible = false
				$Interface/Missions/UIQuests/ControlQ/PanelQ.visible = false
				$Interface/Inventory/UInventory.visible = false
				$Interface/Gloss/UIgloss.visible = false
				$Interface/Missions/UIQuests.visible = false
				get_tree().paused = false
				back_menue_bool = false
				return
		if(get_parent().get_node("Player").get_node("CameraPlayer").current == true):
			position.x = get_parent().get_node("Player").get_node("PlayerCollision").global_position.x - 741
			position.y = get_parent().get_node("Player").get_node("PlayerCollision").global_position.y - 530
			if back_menue_bool == false and (get_tree().paused == false):
				#если игрок двигался
				if get_parent().get_node("Player").isPlayerMoved == true:
					#пихаем камеру в центр
					get_parent().get_node("Player").get_node("CameraPlayer").offset_h = 0
					get_parent().get_node("Player").get_node("CameraPlayer").offset_v = 0 
					#таймер
					var t = Timer.new()
					t.set_wait_time(0.4)
					t.set_one_shot(true)
					self.add_child(t)
					t.start()
					yield(t, "timeout")
					t.queue_free()
					get_parent().get_node("Player").isPlayerMoved = false
					#
				$Interface.visible = true
				var quests = get_parent().get_player().quests
				$Interface/Missions.visible = true
				$Interface/Missions/UIQuests/ControlQ.toggle_quest(quests)
				$Interface/Missions/UIQuests.visible = true
				#
				get_tree().paused = true
				back_menue_bool = true
				return
			if back_menue_bool == true:
				$Interface/Missions.visible = false
				$Interface/Inventory.visible = false
				$Interface/Map.visible = false
				$Interface/Gloss.visible = false
				$Interface/Last.visible = false
				$Interface.visible = false
				$Interface/Inventory/UInventory/Control/Panel.visible = false
				$Interface/Gloss/UIgloss/ControlGloss/PanelGloss.visible = false
				$Interface/Missions/UIQuests/ControlQ/PanelQ.visible = false
				$Interface/Inventory/UInventory.visible = false
				$Interface/Gloss/UIgloss.visible = false
				$Interface/Missions/UIQuests.visible = false
				get_tree().paused = false
				back_menue_bool = false
				return
