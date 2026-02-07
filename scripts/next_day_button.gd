extends Area2D

@onready var time_mgt = get_node('/root/main/time_mgt')

func _on_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if not visible:
		return

	if event is InputEventMouseButton:
		if event.pressed:
			button_pressed()

func button_pressed():
	time_mgt.go_to_next_day()
