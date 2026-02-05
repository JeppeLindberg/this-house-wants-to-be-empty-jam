extends Node2D

@onready var main = get_node('/root/main')
@onready var world = get_node('/root/main/world')

var guest = null

var target_floor = 0
var elevator = null


func initialize():
	main = get_node('/root/main')
	world = get_node('/root/main/world')
	guest = get_parent().get_parent()
	var guest_interactables = main.get_children_in_group(world, 'guest_interactable')

	for interactable in guest_interactables:
		if interactable.get_parent().is_in_group('elevator'):
			elevator = interactable.get_parent()
		
	elevator.call_to_floor(target_floor)

func process_behaviour(_delta):
	if elevator.current_floor() == target_floor:
		guest.reparent(elevator.get_parent())
		queue_free()
		 
