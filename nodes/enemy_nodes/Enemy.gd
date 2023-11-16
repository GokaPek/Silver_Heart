extends Area2D

var player
var speed = 100
var delta = 10
var stop_distance = 200
var hp = 100
var damage = 10
var timer
var can_hit = true
	
func _ready():
	player = get_parent().get_parent().get_player()
	#animation_player = get_node("AnimationPlayer")  # Предполагается, что у вас есть узел AnimationPlayer с именем "AnimationPlayer"
	
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.5  # Время ожидания таймера в секундах
	timer.connect("timeout", self, "_on_Timer_timeout")  # Подключаем сигнал "timeout" к функции _on_Timer_timeout
	timer.start()  # Запускаем таймер
	
func _process(delta):
	var direction = (player.position - position).normalized()
	var distance = position.distance_to(player.position)
	if distance > stop_distance:
		position += direction * speed * delta
		
		#if direction.x > 0:
		#	animation_player.play("move_right")  # Предполагается, что у вас есть анимация "move_right"
		#elif direction.x < 0:
		#	animation_player.play("move_left")  # Предполагается, что у вас есть анимация "move_left"
		#elif direction.y > 0:
		#	animation_player.play("move_down")  # Предполагается, что у вас есть анимация "move_down"
		#elif direction.y < 0:
		#	animation_player.play("move_up")  # Предполагается, что у вас есть анимация "move_up"
	elif distance <= stop_distance and can_hit:
		player.hit(damage)
		can_hit = false
		timer.start()  # Перезапускаем таймер

func _on_Timer_timeout():
	can_hit = true

func hit(damage):
	hp -= damage
	#if hp <= 0:
	#	die()

func die():
	queue_free()  # Удаляет объект из игры
