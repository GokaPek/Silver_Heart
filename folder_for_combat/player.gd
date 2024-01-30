extends KinematicBody2D
var list_of_animations = ["attack_1","attack_2","attack_3"]
var current_list_of_animations = []
var avaible_list_of_animations = ["attack_1", "attack_2", "attack_3"] #доступные игроку приемы, остальные закупаются
export(int) var index_current_animation = -1
var anim_machine 
export (int) var walk_speed = 50
export (int) var run_speed = 200
export (bool) var can_movement = true
var velocity = Vector2()
#bababoy
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#проверка очереди анимаций -> если есть очередь, то включается следующая зависимая анимация
#				-> если нет, то включается зависимая анимация в дефолт стойку

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_machine = $Anim_tree.get("parameters/playback")
	$Anim_tree.active = true

func combat():
	anim_tree_check()
	if Input.is_action_just_pressed("light_attack"):
		if len(current_list_of_animations) <3:
			if current_list_of_animations.empty():
				current_list_of_animations.append("attack_1")
			else:
				if "attack_1" in current_list_of_animations and not "attack_2" in current_list_of_animations:
					current_list_of_animations.append("attack_2")
#	проверяется есть ли предыдущая анимация. Если она есть, то мы добавляем следующую за ней
#в это же время не должно быть такой же анимации в списке, иначе добавится дупликат, а оно нам нахуй не нужно
				elif "attack_2" in current_list_of_animations and not "attack_3" in current_list_of_animations:
					if "attack_3" in avaible_list_of_animations:
						current_list_of_animations.append("attack_3")
	if Input.is_action_just_pressed("heavy_attack"):
		anim_machine.travel("heavy_flipkick")
	if Input.is_action_just_pressed("special"):
		if velocity.length() in range(walk_speed+5,run_speed+5):
			can_movement = false
			anim_machine.travel("heavy_spinkick")
#	GlobalForCombat.test_value = len(current_list_of_animations)
func anim_movement():
	if velocity.x == 0 and velocity.y == 0:
		anim_machine.travel("dflt")
	if velocity.length() in range(1,walk_speed+5):
		if velocity.x > 0:
			$anim_sprite.flip_h = false
		if velocity.x < 0:
			$anim_sprite.flip_h = true
		anim_machine.travel("walk")
	if velocity.length() in range(walk_speed+5,run_speed+5):
		if velocity.x > 0:
			$anim_sprite.flip_h = false
		if velocity.x < 0:
			$anim_sprite.flip_h = true
		anim_machine.travel("run")

func movement():
	if can_movement:
	#	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_right")
		velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down") * walk_speed
		
		if Input.is_action_pressed("acceleration"):
			velocity = velocity.normalized()
			velocity *= run_speed
		velocity = move_and_slide(velocity,Vector2(0,-1))
		anim_movement()
	

	
func _physics_process(delta):
	$Label.text = str(current_list_of_animations)
	movement()
	combat()
			
			

func check_attack_1_end():
	if current_list_of_animations[0] == "attack_1":
		current_list_of_animations.remove(0)
	if current_list_of_animations.empty():
		anim_machine.travel("from_atack_1_to_deflt")
#	if current_list_of_animations.empty() == false:
#		anim_machine.travel("attack_2")
		
func check_attack_2_end():
	if current_list_of_animations[0] == "attack_2":
		current_list_of_animations.remove(0)
	if current_list_of_animations.empty():
		anim_machine.travel("from_atack_2_to_deflt")
#	if current_list_of_animations.empty() == false:
#		anim_machine.travel("attack_3")

func check_attack_3_end():
	if current_list_of_animations[0] == "attack_3":
		current_list_of_animations.remove(0)
	if current_list_of_animations.empty():
		anim_machine.travel("from_atack_3_to_deflt")

func anim_tree_check():
	if current_list_of_animations.empty() == false:				
		match current_list_of_animations[0]:
			"attack_1":
				anim_machine.travel("attack_1")
			"attack_2":
				anim_machine.travel("attack_2")
			"attack_3":
				anim_machine.travel("attack_3")
				
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_anim_animation_finished(anim_name):
	print("ffff")
