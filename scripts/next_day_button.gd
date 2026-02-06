extends Area2D

func _on_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if not visible:
		return

	if event is InputEventMouseButton:
		if event.pressed:
			button_pressed()

func button_pressed():
	print('button_pressed')
