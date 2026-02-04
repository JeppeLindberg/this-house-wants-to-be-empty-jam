extends Area2D

var event_script = null

func _on_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			print(event_script.manuscript)
			event_script.trigger_finished()
			queue_free()


func is_finished():
	return is_queued_for_deletion()

