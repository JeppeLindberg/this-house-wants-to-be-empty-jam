extends Node2D

@onready var main = get_node('/root/main')
@onready var world = get_node('/root/main/world')
@onready var room_mgt = get_node('/root/main/room_mgt')

var guest = null

var guest_interactable
var elevator = null
var room = null


func initialize():
	main = get_node('/root/main')
	world = get_node('/root/main/world')
	guest = get_parent().get_parent()
	var guest_interactables = main.get_children_in_group(world, 'guest_interactable')

	for interactable in guest_interactables:
		if interactable.get_parent().is_in_group('elevator'):
			elevator = interactable.get_parent()

	room = room_mgt.get_room_node(guest.room_number)

func process_behaviour(delta):
	if guest.global_position.distance_to(elevator.global_position) < 1.0 and room_mgt.get_floor(guest) != room_mgt.get_floor(room):
		guest.move_to(elevator)
		var new_task = guest.insert_task(0, 'wait_in_elevator')
		new_task.target_floor = room_mgt.get_floor(room).number
		return

	if abs(global_position.x - elevator.global_position.x) < 1.0 and room_mgt.get_floor(guest) != room_mgt.get_floor(room):
		guest.insert_task(0, 'wait_for_elevator')
		return		

	if room_mgt.get_floor(guest) != room_mgt.get_floor(room):
		guest.insert_task(0, 'go_to_elevator')
		return

	if room_mgt.get_floor(guest) == room_mgt.get_floor(room):
		guest.move_guest_toward(room, delta)

		if guest.global_position.distance_to(room.global_position) < 1.0:
			guest.insert_task(0, 'wait_in_room')

			queue_free()
		 
