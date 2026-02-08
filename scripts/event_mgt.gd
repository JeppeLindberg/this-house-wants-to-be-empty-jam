extends Node

@onready var main = get_node('/root/main')
@onready var events = get_node('/root/main/events')

@export var event_prefab: PackedScene

var allow_new_events = true


func spawn_event(event_script, source_node):
	if not allow_new_events:
		return null

	var event = event_prefab.instantiate()
	events.add_child(event)
	event.global_position = source_node.global_position
	event.event_script = event_script
	event_script.trigger_event_spawned()
	return event
	
