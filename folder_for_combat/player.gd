extends KinematicBody2D
var list_of_animations = ["attack_1","attack_2"]
var current_list_of_animations = []
export(int) var index_current_animation = -1
var anim_machine 


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#проверка очереди анимаций -> если есть очередь, то включается следующая зависимая анимация
#				-> если нет, то включается зависимая анимация в дефолт стойку

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_machine = $Anim_tree.get("parameters/playback")
	$Anim_tree.active = true
	
func _process(delta):
	$Label.text = str(GlobalForCombat.test_value)
	anim_tree_check()
	if Input.is_action_just_pressed("attack"):
		if len(current_list_of_animations) <=3:
			if current_list_of_animations.empty():
				current_list_of_animations.append("attack_1")
			else:
				if index_current_animation == 0:
					current_list_of_animations.append("attack_2")
	GlobalForCombat.test_value = current_list_of_animations
			
			

func check_attack_1_end():
	if current_list_of_animations[0] == "attack_1":
		current_list_of_animations.remove(0)
	if current_list_of_animations.empty():
		anim_machine.travel("from_atack_1_to_deflt")
	if current_list_of_animations.empty() == false:
		anim_machine.travel("attack_2")
		
func check_attack_2_end():
	if current_list_of_animations[0] == "attack_2":
		current_list_of_animations.remove(0)
	if current_list_of_animations.empty():
		anim_machine.travel("from_atack_2_to_deflt")
#	if current_list_of_animations.empty() == false:
#		anim_machine.travel("attack_2")

func anim_tree_check():
	if current_list_of_animations.empty() == false:				
		match current_list_of_animations[0]:
			"attack_1":
				anim_machine.travel("attack_1")
			"attack_2":
				anim_machine.travel("attack_2")
				
				
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_anim_animation_finished(anim_name):
	print("ffff")
