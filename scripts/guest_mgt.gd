extends Node2D

@export var go_to_reception: PackedScene
@export var discuss_stay: PackedScene
@export var go_to_room: PackedScene
@export var wait_in_room: PackedScene
@export var go_to_elevator: PackedScene
@export var wait_for_elevator: PackedScene
@export var wait_in_elevator: PackedScene
@export var hesitate: PackedScene
@export var wait_for_event_finished: PackedScene

func get_task_prefab(task_name) -> PackedScene:
	if task_name == 'go_to_reception':
		return go_to_reception
	if task_name == 'discuss_stay':
		return discuss_stay
	if task_name == 'go_to_room':
		return go_to_room
	if task_name == 'wait_in_room':
		return wait_in_room
	if task_name == 'go_to_elevator':
		return go_to_elevator
	if task_name == 'wait_for_elevator':
		return wait_for_elevator
	if task_name == 'wait_in_elevator':
		return wait_in_elevator
	if task_name == 'hesitate':
		return hesitate
	if task_name == 'wait_for_event_finished':
		return wait_for_event_finished

	return null

