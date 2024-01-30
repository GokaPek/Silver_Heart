extends KinematicBody2D
const SPEED = 20
const FLOOR = Vector2(0, -1)
const GRAVITY = 75
var velocity = Vector2()
var direction = 1
var rng_combat = RandomNumberGenerator.new()
var time_for_wait_or_go = RandomNumberGenerator.new()
var plus_x = RandomNumberGenerator.new()
var plus_y = RandomNumberGenerator.new()
var plus_y_var = 0
var plus_x_var = 0
var ouch_direction = 1
var targetBody
var pos_before_fatal_bonk = Vector2(0,0)
var self_dir_of_bonk = Vector2()
var HP = 45
var state_anim
var dis_to_Biba
var dis_to_Boba
var Body_attack = null             #вот эти две переменные обозначают именно значение врага, а с маленькой буквы означают аргументы. Не путать!
var Body_under_atack = null 
var who_near = []   
var can_do = false #
var reccomend_dist = 60
var i_rily_can_beat = false
export(int) var selfposition # эта штука нужна для анимации. Скорее всего потом появится переменная с ключом, используй для пермемещения во время анимации
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(bool) var can_beat = true
export(bool) var can_walk = true
export(bool) var damage_now = false
export(bool) var get_fatal_damage = false
export(int) var damage_dist_at_the_moment = 0 #расстояние, на которое сейчас отлетает
var any_combat = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	can_beat = false
	can_walk = true
	damage_now = false
	get_fatal_damage = false
	$Hitbox.disabled = false
	rng_combat.randomize()
	time_for_wait_or_go.randomize()
	plus_x.randomize()
	plus_y.randomize()
	state_anim = $AnimationTree.get("parameters/playback")
	$Area2D/CollisionShape2D.shape.extents = Vector2(4.5,8)
	$Area2D/CollisionShape2D.position = Vector2(0,0)
	$AnimationTree.active = true
	#$go.start()
func walk():
	if damage_now == false and get_fatal_damage == false:
		if $RayCast2D.get_collider() == null or "Chop" in $RayCast2D.get_collider().name:
			velocity = global_position.direction_to(the_nearest().global_position + Vector2(plus_x_var,plus_y_var)) * SPEED
			if global_position.distance_to(the_nearest().global_position + Vector2(plus_x_var,plus_y_var)) > 15:
				velocity = move_and_slide(velocity)
				state_anim.travel("Run")
		else:
			velocity.x = 0
			state_anim.travel("Idle")
		velocity = move_and_slide(velocity,FLOOR)

func look():
	if HP > 5 and get_fatal_damage != true:
		if global_position.x < the_nearest().global_position.x:
			$Chop.flip_h = false

			$Bonk_area/CollisionShape2D.position.x = 5
			

		if global_position.x > the_nearest().global_position.x:
			$Chop.flip_h = true

			$Bonk_area/CollisionShape2D.position.x = -5
	
	
func _physics_process(delta):
	Y_sort_who_near()
	in_bonk(delta, pos_before_fatal_bonk, self_dir_of_bonk,damage_dist_at_the_moment)
	if HP > 5:
		look()
		if $go.time_left != 0:
			if can_walk and can_do:
				walk()
		$RayCast2D.set_cast_to(global_position.direction_to(the_nearest().global_position + Vector2(plus_x_var,plus_y_var)).normalized() * 8)
	
	can_attack()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

func can_attack():
	if (global_position.distance_to(the_nearest().global_position) < reccomend_dist) and HP > 5:
		can_walk = false
		if can_beat and HP > 5 and i_rily_can_beat:
			any_combat = rng_combat.randi_range(0,1)
			if any_combat == 1:
				can_walk = false
				state_anim.travel("Bonk")
				$AudioStreamPlayer2D.play()
			if any_combat == 0:
				can_walk = false
				state_anim.travel("Ukol")
				$AudioStreamPlayer2D2.play()
			can_beat = false
			$Calldawn.start()
	else:
		can_walk = true
		get_parent().get_parent().body_attack(null,null)
		#emit_signal("player_under_attack",null,null)
##необходима анимация, с помощью которой 
#враг отпихивает бибобу от себя на расстояние больше 10. 
#Это нужно для того, чтобы обновить Combat_zone.
#Если can_beat==true, то враг ударяет как обычно
#Если can_beat==false, то враг отпихивает бибобу
func the_nearest():
	if get_parent().Target_object == get_node("../Boba"):
		dis_to_Biba = global_position.distance_to(get_node("../Biba").global_position)
		dis_to_Boba = global_position.distance_to(get_node("../Boba").global_position)
		if dis_to_Boba < dis_to_Biba:
			return get_node("../Boba")
		if dis_to_Boba > dis_to_Biba:
			return get_node("../Biba")
	else:
		return get_parent().Target_object
func _on_Bonk_area_body_entered(body):
	if body.is_in_group("BibaBoba"):
		if body.alive:
			if global_position.x < body.global_position.x:
				if body.has_method("bonk"):
					body.bonk(1,5)
			if global_position.x > body.global_position.x:
				if body.has_method("bonk"):
					body.bonk(-1,5)
			can_beat = true
			if any_combat == 1:
				$AudioStreamPlayer2D3.play()
			if any_combat == 0:
				$AudioStreamPlayer2D4.play()



func in_bonk(var delta, var pos_B, var dir_bonk,var dist):
	if get_fatal_damage:
		pos_B.x = pos_B.x + (dist * dir_bonk)
		global_position = global_position.linear_interpolate(pos_B, delta * 2)




func get_damage(var pos_from,var damage):      #позиция того, кто ударил
	can_walk = false
	damage_now = true
	can_beat = false
	HP -= damage
	if global_position.x < pos_from.x:
		ouch_direction = -1
		$Chop.flip_h = false
		$Bonk_area/CollisionShape2D.position.x = 5
		$Chop/AnimationPlayer.stop()
		state_anim.travel("Get_damage")
	elif global_position.x > pos_from.x:
		ouch_direction = 1
		$Chop.flip_h = true
		$Bonk_area/CollisionShape2D.position.x = -5
		$Chop/AnimationPlayer.stop()
		state_anim.travel("Get_damage")
		
func get_bonk(var pos_from):
	can_walk = false
	can_beat = false
	#get_fatal_damage = true
	pos_before_fatal_bonk = global_position
	self_dir_of_bonk = sign(pos_from.x - position.x) * -1
	$AnimationTree.active = false
	$Chop/AnimationPlayer.play("Die",-1,0.8)
	#$Chop/AnimationPlayer.play("Fatal_get_damage",-1,1.2)

func get_bonk_from_bullet_fatal(var pos_from,var dist,var damage):
	HP -= damage
	can_walk = false
	can_beat = false
	damage_dist_at_the_moment = dist
	#get_fatal_damage = true
	pos_before_fatal_bonk = global_position
	self_dir_of_bonk = sign(pos_from.x - position.x) * -1
	$AnimationTree.active = false
	$Chop/AnimationPlayer.play("Fatal_get_damage",-1,1.2)

func get_bonk_from_bullet(var pos_from,var dist,var damage):
	HP -= damage
	can_walk = false
	can_beat = false
	damage_dist_at_the_moment = dist
	#get_fatal_damage = true
	pos_before_fatal_bonk = global_position
	self_dir_of_bonk = sign(pos_from.x - position.x) * -1
	state_anim.travel("Fatal_get_damage")
	

func _on_Bonk_time_timeout():
	can_beat = true



	






func _on_Area2D_body_entered(body):
	if body != self:
		who_near.append(body)


func _on_Area2D_body_exited(body):
	who_near.erase(body)

func Y_sort_who_near():
	for i in who_near:
		if i.global_position.y < global_position.y:
			set_z_index(i.get_z_index() + 1) 
		if i.global_position.y > global_position.y:
			set_z_index(i.get_z_index() - 1)


func _on_go_timeout():
	$wait.start(time_for_wait_or_go.randf_range(2,6))
	state_anim.travel("Idle")


func _on_wait_timeout():
	$go.start(time_for_wait_or_go.randf_range(2,6))
	if i_rily_can_beat:
		plus_x_var = plus_x.randi_range(-400,400)
		plus_y_var = plus_y.randi_range(-50,50)
	else:
		plus_x_var = 0
		plus_y_var = 0
func _on_y_sorted_body_entered(body):
	if body != self:
		who_near.append(body)



