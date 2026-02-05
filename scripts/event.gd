extends Area2D

@onready var event_feed = get_node('/root/main/event_feed')

var event_script = null

func _on_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if not visible:
		return

	if event is InputEventMouseButton:
		if event.pressed:
			event_feed.begin_script(event_script, self)
			visible = false


func is_finished():
	return is_queued_for_deletion()
