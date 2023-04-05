extends Control


func toggle_inventory(inventory):
	if $Panel.visible:
		$Panel.clear()
		$Panel.visible = false
		$Label.visible = false
		$Money.visible = false
	else:
		$Panel.visible = true
		$Panel.show_inventory(inventory)
		$Label.visible = true
		$Money.visible = true
		var money = str(get_parent().get_parent().get_parent().get_parent().get_parent().get_player().money)
		$Money.text = money
		
func update_inventory(inventory):
	if $Panel.visible:
		$Panel.show_inventory(inventory)
