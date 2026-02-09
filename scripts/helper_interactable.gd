extends Area2D

@onready var mouse_container = get_node('/root/main/mouse_follower/container')
@onready var main = get_node('/root/main')
@onready var container = get_node('container')


func _on_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if not visible:
		return

	if event is InputEventMouseButton:
		if event.pressed:
			click_down()
		elif not event.pressed:
			click_up()

func click_down():
	pass

func click_up():
	var helpers = main.get_children_in_group(mouse_container, 'helper')
	if len(helpers) > 0:
		var helper = helpers[0]
		helper.move_to(container)
		return
