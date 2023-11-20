extends Area2D

var active = false
var is_talcked_grandpa = false

func _ready():
	if 'is_talcked_grandpa' in get_parent().get_player().bool_var.keys():
		queue_free()
	connect("body_entered", self, '_on_NPC_body_entered')
	connect("body_exited", self, '_on_NPC_body_exited')


#func _process(delta):
	#$SpritePDA.visible = active
	
func _input(event):
	#print(get_parent().get_player().bool_var)
	if get_node_or_null('DialogeNode')  == null:
		if ( event.is_action_pressed("e_click") or $Button.pressed) and active:
			get_tree().paused = true
			var dialog = Dialogic.start('grand_pa')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			add_child(dialog)
			is_talcked_grandpa = true
			get_parent().get_player().set_bool('is_talcked_grandpa', true)
			#get_parent().get_node("Quest_adder").quest_go_work()

func unpause(timeline_name):
	get_tree().paused = false

func _on_NPC_body_entered(body):
	if body.name == "Player":
		active = true
		
func _on_NPC_body_exited(body):
	if body.name == "Player":
		active = false
		if is_talcked_grandpa:
			queue_free()