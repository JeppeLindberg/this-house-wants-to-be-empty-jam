extends Node2D

@onready var main = get_node('/root/main')
@onready var world = get_node('/root/main/world')
@onready var room_mgt = get_node('/root/main/room_mgt')

var guest = null

var target = null


func initialize():
	main = get_node('/root/main')
	world = get_node('/root/main/world')
	guest = get_parent().get_parent()

func process_behaviour(delta):
	var room = room_mgt.get_room_node(guest.room_number)

	if room_mgt.get_floor(self) != room_mgt.get_floor(room):
		guest.insert_task(0, 'go_to_elevator')
		return

	guest.move_guest_toward(target, delta)

	if guest.global_position.distance_to(target.global_position) < 1.0:
		guest.insert_task(0, 'wait_in_room')

		queue_free()
		 
