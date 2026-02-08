extends Area2D

@onready var mouse_container = get_node('/root/main/mouse_follower/container')


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
	pass

