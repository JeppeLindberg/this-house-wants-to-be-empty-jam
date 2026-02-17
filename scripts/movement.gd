extends Node2D

@onready var main = get_node('/root/main')
@onready var guest_detector = get_node('guest_detector')

const MOVE_SPEED = 100.0

var target_movement = 'none'
var target_position_x = 0.0

func _process(delta: float) -> void:
	delta *= main.world_time_mult()
	
	var x_movement = 0.0
	if target_movement == 'left':
		x_movement += 1.0
	if target_movement == 'right':
		x_movement += 1.0

	get_parent().global_position.x = move_toward(get_parent().global_position.x, target_position_x, x_movement * MOVE_SPEED * delta)

func walk_toward(node, queue_behind_nodes_with_tasks = [], queue_behind_nodes_in_state = []):	
	target_position_x = node.global_position.x

	if abs(target_position_x - get_parent().global_position.x) < 1.0:
		target_movement = 'none'
	elif target_position_x < get_parent().global_position.x:
		target_movement = 'left'
	elif get_parent().global_position.x < target_position_x:
		target_movement = 'right'
	
	if queue_behind_nodes_with_tasks == [] and queue_behind_nodes_in_state == []:
		return

	var nodes = main.get_nodes_in_shape(guest_detector)
	for guest in nodes:
		if target_movement in ['none', 'queued']:
			break
		if guest == get_parent():
			continue
		if not guest.is_in_group('guest'):
			continue

		var other_guest = null
		if guest.has_method('get_current_task_name') and guest.get_current_task_name() in queue_behind_nodes_with_tasks:
			other_guest = guest
		elif guest.has_method('get_current_state') and guest.get_current_state() in queue_behind_nodes_in_state:
			other_guest = guest
		
		if other_guest != null:
			if other_guest.global_position.x < get_parent().global_position.x and target_movement == 'left':
				target_movement = 'queued'
			if get_parent().global_position.x < other_guest.global_position.x and target_movement == 'right':
				target_movement = 'queued'
