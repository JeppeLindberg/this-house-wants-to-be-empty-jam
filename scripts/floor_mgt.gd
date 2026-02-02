extends Node2D

@onready var main = get_node('/root/main')
@onready var world = get_node('/root/main/world')


func get_floor_node(floor_number):
	# print('get_floor_node ' + str(floor_number))
	var floors = main.get_children_in_group(world, 'floor')
	for _floor in floors:
		if 'number' in _floor and _floor.number == floor_number:
			return _floor
	
	return null


func get_floor(node):
	return main.find_in_parents(node, 'floor')
