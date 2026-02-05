extends Node2D

@onready var main = get_node('/root/main')
@onready var world = get_node('/root/main/world')
@onready var event_mgt = get_node('/root/main/event_mgt')

var guest = null

var target = null


func initialize():
	main = get_node('/root/main')
	world = get_node('/root/main/world')
	guest = get_parent().get_parent()
	var guest_interactables = main.get_children_in_group(world, 'guest_interactable')

	for interactable in guest_interactables:
		if interactable.get_parent().is_in_group('entrance'):
			target = interactable.get_parent()

func process_behaviour(delta):
	guest.move_guest_toward(target, delta)
	
	if guest.global_position.distance_to(target.global_position) < 1.0:
		guest.queue_free()
		 
