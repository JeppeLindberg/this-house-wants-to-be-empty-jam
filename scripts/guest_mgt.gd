extends Node2D

@export var go_to_reception: PackedScene
@export var discuss_stay: PackedScene
@export var go_to_room: PackedScene
@export var wait_in_room: PackedScene

func get_task_prefab(task_name) -> PackedScene:
	if task_name == 'go_to_reception':
		return go_to_reception
	if task_name == 'discuss_stay':
		return discuss_stay
	if task_name == 'go_to_room':
		return go_to_room
	if task_name == 'wait_in_room':
		return wait_in_room

	return null

