extends Node

@onready var main = get_node('/root/main')
@onready var world = get_node('/root/main/world')


func get_room_node(room_number):
	var rooms = main.get_children_in_group(world, 'room')
	for room in rooms:
		if 'number' in room and room.number == room_number:
			return room
	
	return null

func get_floor(node):
	return main.find_in_parents(node, 'floor')

func assign_random_room():
	var possible_rooms = []
	for room in main.get_children_in_group(world,'room'):
		if 'available' in room.attributes:
			possible_rooms.append(room)
	
	var room = possible_rooms.pick_random()	
	room.attributes.erase('available')
	room.attributes.append('occupied')
	return room
