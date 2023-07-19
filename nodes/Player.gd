extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 200
const AIR_RESISTENCE = 0.05

var motion = Vector2.ZERO
var idle = "idle_front"
var isAttacking = false
#переменнная если игрок двигался
var isPlayerMoved = true

#система передвижения
func _physics_process(delta):
	#обработка события нажатия клавишь
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var y_input = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if x_input != 0 && isAttacking == false:
		isPlayerMoved = true
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	if y_input != 0 && isAttacking == false:
		isPlayerMoved = true
		motion.y += y_input * ACCELERATION * delta
		motion.y = clamp(motion.y, -MAX_SPEED, MAX_SPEED)
	motion = move_and_slide(motion, Vector2.UP)
	#остановка со временем
	motion.x = lerp(motion.x, 0, AIR_RESISTENCE)
	motion.y = lerp(motion.y, 0, AIR_RESISTENCE)
	if x_input == 0 and y_input == 0:
		motion.x = 0
		motion.y = 0


#анимация


	var anim = "idle_front"
	if isAttacking == false:
		if y_input > 0:
			anim = "walk_front"
			idle = "idle_front"
			$Hort.play(anim)
		elif y_input < 0:
			anim = "walk_back"
			idle = "idle_back"
			$Hort.play(anim)
		elif x_input > 0:
			anim = "walk_right"
			idle = "idle_right"
			$Hort.play(anim)
		elif x_input < 0:
			anim = "walk_left"
			idle = "idle_left"
			$Hort.play(anim)

	if Input.is_action_just_pressed("attack_start"):
#		if (idle == "idle_right"):
#			$Hort.play("attack");
#			$AttackArea/AttackRight.disabled = false;
#			isAttacking = true;
#		if (idle == "idle_left"):
#			$Hort.play("attack");
#			$AttackArea/AttackLeft.disabled = false;
#			isAttacking = true;
#		if (idle == "idle_back"):
#			$Hort.play("attack");
#			$AttackArea/AttackUp.disabled = false;
#			isAttacking = true;
#		if (idle == "idle_front"):
#			$Hort.play("attack");
#			$AttackArea/AttackDown.disabled = false;
#			isAttacking = true;
		$Hort.play("attack_start")
		$AttackArea/AttackRight.disabled = false
		isAttacking = true
	if Input.is_action_just_pressed("attack_up"):
		$Hort.play("blade_up")
		$AttackArea/AttackRight.disabled = false
		isAttacking = true


	if Input.is_action_just_pressed("attack_down"):
		$Hort.play("blade_down")
		$AttackArea/AttackRight.disabled = false
		isAttacking = true
	if Input.is_action_just_pressed("attack_finish"):
		$Hort.play("attack_finish",true)
		$AttackArea/AttackRight.disabled = false
		isAttacking = true
	if ((x_input == 0 ) and (y_input == 0 )) and isAttacking == false:
		anim=idle
		$Hort.play(anim)
#конец проигрывания анимации атаки
func _on_Hort_animation_finished():
	if $Hort.animation == "attack_finish":
		$AttackArea/AttackRight.disabled = true;
		$AttackArea/AttackLeft.disabled = true;
		$AttackArea/AttackUp.disabled = true;
		$AttackArea/AttackDown.disabled = true;
		isAttacking = false;
#хз как должно быть, но пока шо работает так: мы вытаскиваем с помощью blade_up клинок и махаемся им. И пока он у нас в руках, двигаться мы, як я разумею, не можэ. И как только мы запихиваем сей клинок обратно, двигаться могем. Чет муторно как-то, но шо естьб

#задел на характеристики персонажа

var vision_lvl = 0

#система предметов
var inventory = {}
func pick(item):
	var it = item.get_name()
	#print("Get %s" % str(it))
	if it in inventory.keys():
		inventory[it] += item.get_amount() 
	else:
		inventory[it] = item.get_amount() 
		

#система глоссария
var gloss = {}
var gloss_persons = {}
var gloss_world = {}
func get_gloss(name, inf):
	if name in gloss.keys():
		 return;
	else:
		gloss[name] = inf
func get_gloss_persons(name, inf):
	if name in gloss_persons.keys():
		 return;
	else:
		gloss_persons[name] = inf
func get_gloss_world(name, inf):
	if name in gloss_world.keys():
		 return;
	else:
		gloss_world[name] = inf 
		

#система квестов
var quests = {}
var complited_quests = {}
func get_quest(name):
	if name in quests.keys():
		 return;
	else:
		quests[name] = {}
func get_quest_mission(name, name_quest):
	if name in quests.keys():
		if name_quest in quests[name].keys():
			return
		else:
			quests[name][name_quest]=false
func do_quest(name):
	if name in quests.keys():
		 quests[name]=null
	if name in complited_quests.keys():
		 return;
	else:
		complited_quests[name] = {}
func do_quest_mission(name, name_quest):
	if name in quests.keys():
		if name_quest in quests[name].keys():
			quests[name][name_quest]=true
			
			
#деньги
var money = 0
