extends TextureRect
var call
var information
func set_gloss(name, inf):
	#$RichTextLabel.text = inf
	$Label.text = name
	call = name
	information = inf
func _input(event):
	name = $Label.text
	if ($Button.pressed == true):
		var im = load("res://sprites/glossimages/%s.png" % name)
		get_parent().get_parent().get_parent().get_parent().get_parent().get_node("Image").set_texture(im)
		get_parent().get_parent().get_parent().get_parent().get_parent().get_node("Call").text = call
		get_parent().get_parent().get_parent().get_parent().get_parent().get_node("Information").text = information
