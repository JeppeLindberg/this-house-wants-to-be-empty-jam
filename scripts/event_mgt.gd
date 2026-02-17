extends Node

@onready var main = get_node('/root/main')
@onready var events = get_node('/root/main/events')
@onready var time_mgt = get_node('/root/main/time_mgt')

@export var event_prefab: PackedScene


func spawn_event(event_script, source_node):
	if time_mgt.between_days:
		return null

	var event = event_prefab.instantiate()
	events.add_child(event)
	event.global_position = source_node.global_position
	event.event_script = event_script
	event_script.trigger_event_spawned()
	return event
	
