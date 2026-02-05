extends Node2D

@onready var main = get_node('/root/main')
@onready var world = get_node('/root/main/world')
@onready var room_mgt = get_node('/root/main/room_mgt')

var guest = null

var elevator = null


func initialize():
	main = get_node('/root/main')
	world = get_node('/root/main/world')
	guest = get_parent().get_parent()
	var guest_interactables = main.get_children_in_group(world, 'guest_interactable')

	for interactable in guest_interactables:
		if interactable.get_parent().is_in_group('elevator'):
			elevator = interactable.get_parent()

	elevator.call_to_floor(room_mgt.get_floor(self).number)

func process_behaviour(_delta):
	if guest.global_position.distance_to(elevator.global_position) < 1.0:
		queue_free()
		 
