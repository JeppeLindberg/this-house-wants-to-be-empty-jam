extends Node2D

@onready var main = get_node('/root/main')
@onready var world = get_node('/root/main/world')

var task_name = null
var guest = null

var elevator = null


func initialize():
	main = get_node('/root/main')
	world = get_node('/root/main/world')
	guest = get_parent().get_parent()
	var guest_interactables = main.get_children_in_group(world, 'guest_interactable')

	for interactable in guest_interactables:
		if interactable.is_in_group('elevator'):
			elevator = interactable

func process_behaviour(_delta):
	guest.move_guest_toward(elevator)

	if abs(guest.global_position.x - elevator.global_position.x) < 1.0:		
		queue_free()
		 
