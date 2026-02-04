extends Node

@onready var main = get_node('/root/main')
@onready var events = get_node('/root/main/events')

@export var event_prefab: PackedScene


func spawn_event(event_script, source_node):
	var event = event_prefab.instantiate()
	events.add_child(event)
	event.global_position = source_node.global_position
	event.event_script = event_script
	return event
	
