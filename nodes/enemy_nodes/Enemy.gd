extends Area2D

var player
var speed = 100
var delta = 10
var stop_distance = 200

func get_player():
	return player
	
func _ready():
	player = get_parent().get_parent().get_player()
	#animation_player = get_node("AnimationPlayer")  # Предполагается, что у вас есть узел AnimationPlayer с именем "AnimationPlayer"

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
	#else:
		#position = player.position
