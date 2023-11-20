extends Node2D



func _ready():
	pass 

var esc_menue_bool = false
func _input(event):
	if (event.is_action_pressed("ui_cancel") or ($Interface/Button.pressed)):
		#Ввёл проверку на текущую камеру
		if(get_parent().get_node("CameraLoc").current == true):
			position.x = 0
			position.y = 0
			#Если локальная камера текущая, то все действия понятны, они те же, только позиция камеры становится дефолт
			if (esc_menue_bool == false) and (get_tree().paused == false):
				$Interface.visible = true
				get_tree().paused = true
				esc_menue_bool = true
				return
			if esc_menue_bool == true:
				$Interface.visible = false
				get_tree().paused = false
				esc_menue_bool = false
				return
		if(get_parent().get_node("Player").get_node("CameraPlayer").current == true):
			#get_node("Interface").position.x = get_parent().get_node("Player").get_node("PlayerCollision").global_position.x
			#get_node("Interface").position.y = get_parent().get_node("Player").get_node("PlayerCollision").global_position.y
			#С помощью родителей обратился к узлу с кругом взаимодейсвтия игрока и его координатам, отнял их
			#По сути сделал костыль, но, вроде работает, уже хорошо ёп. Можно как-нибудь подкорректировать позже
			position.x = get_parent().get_node("Player").get_node("Center").global_position.x - 741
			position.y = get_parent().get_node("Player").get_node("Center").global_position.y - 457
			if (esc_menue_bool == false) and (get_tree().paused == false):
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
				get_tree().paused = true
				esc_menue_bool = true
				return
			if esc_menue_bool == true:
				$Interface.visible = false
				get_tree().paused = false
				esc_menue_bool = false
				return

func _physics_process(delta):
			if $Interface/Exit.pressed:
					get_tree().quit()
