extends Node2D

@onready var main = get_node('/root/main')
@onready var world = get_node('/root/main/world')

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

func process_behaviour(delta):
	guest.move_guest_toward(elevator, delta)

	if abs(guest.global_position.x - elevator.global_position.x) < 1.0:		
		queue_free()
		 
