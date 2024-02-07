extends KinematicBody2D

export(int) var walk_speed = 40
export(int) var run_speed = 160
export(bool) var can_movement = true
var velocity = Vector2()
export(bool) var moving_at_moment = false
export(int) var change_to_logic
export(int) var zone_to_prepare_atack = 100
export(int) var zone_to_idle = 10 #зона в игре увеличиться в 10 раз
export(int) var zone_x_to_retreat = 7 #зона в игре увеличиться в 10 раз
export(int) var zone_y_to_retreat = 7 #зона в игре увеличиться в 10 раз
var rnd = RandomNumberGenerator.new()
var target = Vector2.ZERO
var state = "idle"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func resetup_logic():
	change_to_logic = rnd.randi_range(0,100) #выбирается вариант поведения
	if change_to_logic in range(0,51):
		change_to_prepare_attack()
	elif change_to_logic in range(51,77):
		change_to_idle()
	elif change_to_logic in range(77,101):
		change_to_retreat()
func change_to_idle():
#	GlobalForCombat.test_value ="idle"
	target = Vector2(global_position.x + rnd.randi_range(-zone_to_idle,zone_to_idle)*10,global_position.y)
	state = "idle"
#ходит по прямой	
func change_to_retreat():
#	GlobalForCombat.test_value = "retreat"
	target = Vector2(0,0)
	target.x = global_position.x + rnd.randi_range(-zone_x_to_retreat,zone_x_to_retreat)*10
	target.y = global_position.y + rnd.randi_range(-zone_y_to_retreat,zone_y_to_retreat)*10
	state = "retreat"
func change_to_prepare_attack():
#	GlobalForCombat.test_value = "prepare_attack"
	target.y = GlobalForCombat.player_position.y
	if global_position.x < GlobalForCombat.player_position.x:
		target.x = GlobalForCombat.player_position.x + rnd.randi_range(-zone_to_prepare_atack,-55)
	if global_position.x > GlobalForCombat.player_position.x:
		target.x = GlobalForCombat.player_position.x + rnd.randi_range(55,zone_to_prepare_atack)
	state = "prepare"

func go_to_attack():
	state = "go_attack"
#	GlobalForCombat.test_value = "go_to_attack"
	target.y = GlobalForCombat.player_position.y
	target.x = GlobalForCombat.player_position.x + 35*sign(global_position.x - GlobalForCombat.player_position.x)
	
func always_look():
	if global_position.x < GlobalForCombat.player_position.x:
		$things_to_flip.scale.x = 1
	if global_position.x > GlobalForCombat.player_position.x:	
		$things_to_flip.scale.x = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	rnd.randomize()
	change_to_idle()
	$things_to_flip/attack_box_area/attack_box_collis.set_deferred("disabled",true)
func get_hit():
	$anim_player.stop() #можно использовать разные функции, обрабатывающие попадания в отдельные части тела
	$anim_player.play("get_hit")
func movement_to_target():
#	print(global_position.x - GlobalForCombat.player_position.x, global_position.y == GlobalForCombat.player_position.y)
	if target:
		velocity = global_position.direction_to(target)*walk_speed
		if global_position.distance_to(target) > 10:
			move_and_slide(velocity)
			moving_at_moment = true
		else:
			moving_at_moment = false
		state_check()
func state_check():
	if state == "idle" and $wait_after_idle.time_left == 0 and moving_at_moment == false:
#		GlobalForCombat.test_value = "finish_i"
		$wait_after_idle.start()
	if state == "retreat" and $wait_after_retreat.time_left == 0 and moving_at_moment == false:
		$wait_after_retreat.start()
#		GlobalForCombat.test_value = "finish_r"	
	if state == "prepare" and moving_at_moment == false:
#		GlobalForCombat.test_value = "finish_p"
		go_to_attack()
	if state == "go_attack" and moving_at_moment == false:
		$anim_player.play("attack")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _physics_process(delta):
	always_look()
	movement_to_target()

func _on_hit_box_area_area_entered(area):
	pass


func _on_hit_box_area_area_exited(area):
	pass





func _on_wait_after_idle_timeout():
	resetup_logic()
	#да, я мог использовать yield, но эта залупенко отказалась нормально работать


func _on_wait_after_retreat_timeout():
	resetup_logic()


func _on_ray_cast_attack_area_entered(area):
	print(area.is_in_group("player"))


func _on_attack_box_area_area_entered(area):
	if area.is_in_group("player"):
		area.get_parent().get_parent().get_hit()
