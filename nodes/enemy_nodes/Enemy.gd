extends KinematicBody2D

var player
var animation
var speed = 100
var delta = 10
var stop_distance = 200
#отталкивание
var swap = 10
var hp = 100
onready var hp_bar = get_node("HpBar")
var damage = 10
var timer
var can_hit = true
	
func _ready():
	animation = get_node("AnimatedSprite")
	player = get_parent().get_parent().get_player()
	add_to_group("Enemies")
	player.isCombatMode = true
	hp_bar.value = hp
	
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.5  # Время ожидания таймера в секундах
	timer.connect("timeout", self, "_on_Timer_timeout")  # Подключаем сигнал "timeout" к функции _on_Timer_timeout
	timer.start()  # Запускаем таймер
	
	animation.connect("animation_finished", self, "_on_Animation_finished")
	
func _process(delta):
	var direction = (player.position - position).normalized()
	var distance = position.distance_to(player.position)
	if distance > stop_distance:
		position += direction * speed * delta
		
		if direction.x > 0:
			animation.play("walk_right")  # Предполагается, что у вас есть анимация "move_right"
		elif direction.x < 0:
			animation.play("walk_left")  # Предполагается, что у вас есть анимация "move_left"
		elif direction.y > 0:
			animation.play("walk_down")  # Предполагается, что у вас есть анимация "move_down"
		elif direction.y < 0:
			animation.play("walk_up")  # Предполагается, что у вас есть анимация "move_up"
		
	#elif :
	#	# Если враг не двигается, то включаем анимацию покоя
	#	if direction.x > 0:
	#		animation.play("idle_right")  # Предполагается, что у вас есть анимация "idle_right"
	#	elif direction.x < 0:
	#		animation.play("idle_left")  # Предполагается, что у вас есть анимация "idle_left"
	#	elif direction.y > 0:
	#		animation.play("idle_down")  # Предполагается, что у вас есть анимация "idle_down"
	#	elif direction.y < 0:
	#		animation.play("idle_up")  # Предполагается, что у вас есть анимация "idle_up"
			
	elif distance <= stop_distance and can_hit:
		animation.play("attack_left")
		#player.hit(damage)
		#can_hit = false
		#timer.start()  # Перезапускаем таймер

func _on_Timer_timeout():
	can_hit = true

func _on_Animation_finished():
	var distance = position.distance_to(player.position)
	if animation.animation == "attack_left" and can_hit and (distance <= stop_distance):
		player.hit(damage)
		can_hit = false
		timer.start()  # Перезапускаем таймер
		
		# Отталкиваем игрока от врага
		var direction = (player.position - position).normalized()
		player.position += direction * delta * swap
		

func hit(damage_x):
	hp -= damage_x
	hp_bar.value = hp
	if hp <= 0:
		player.stopCombat()
		die()
	else:
		# Отталкиваем врага от игрока
		var direction = (position - player.position).normalized()
		position += direction * delta * swap
	
func die():
	queue_free()  # Удаляет объект из игры
