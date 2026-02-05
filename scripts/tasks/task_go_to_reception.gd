extends Node2D

@onready var main = get_node('/root/main')
@onready var world = get_node('/root/main/world')
@onready var event_mgt = get_node('/root/main/event_mgt')

var task_name = null
var guest = null

var target = null
var event_script = null


func initialize():
	main = get_node('/root/main')
	world = get_node('/root/main/world')
	guest = get_parent().get_parent()
	var guest_interactables = main.get_children_in_group(world, 'guest_interactable')

	for interactable in guest_interactables:
		if interactable.is_in_group('reception'):
			target = interactable

func process_behaviour(_delta):
	guest.move_guest_toward(target, ['go_to_reception'], ['talking_to_reception', 'standing_in_queue'])
	
	if guest.global_position.distance_to(target.global_position) < 1.0:
		if event_script != null:
			var wait_for_event_finished = guest.insert_task(0, 'wait_for_event_finished')
			wait_for_event_finished.event = event_mgt.spawn_event(event_script, guest)
			queue_free()
		else:
			guest.insert_task(0,'discuss_stay')
			queue_free()
		 
