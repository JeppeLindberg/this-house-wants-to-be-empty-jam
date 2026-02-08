extends Area2D

@onready var main = get_node('/root/main')
@onready var world = get_node('/root/main/world')
@onready var tasks = get_node('tasks')
@onready var task_mgt = get_node('/root/main/task_mgt')
@onready var subscriber_mgt = get_node('/root/main/subscriber_mgt')
@onready var event_mgt = get_node('/root/main/event_mgt')
@onready var room_mgt = get_node('/root/main/room_mgt')
@onready var resources = get_node('/root/main/resources')
@onready var event_scripts = get_node('event_scripts')
@onready var room_detector = get_node('room_detector')
@onready var movement = get_node('movement')

var discuss_stay_event_script: Node2D

const DISCUSS_STAY_SECS = 3.0
const HESITATE_DURATION_SECS = 1.0

var current_task = null
var current_room = null

var room_number = -1

var lifetime = 0.0
var done_discussing_stay = 0.0

var state = ''
var attributes = []



func _ready() -> void:
	add_to_group('guest')

	for child in event_scripts.get_children():
		if child.is_in_group('discuss_stay'):
			discuss_stay_event_script = child
	
	subscriber_mgt.subscribe_day_end_callables(self, collect_rent)
	subscriber_mgt.subscribe_day_start_callables(self, prepare_next_day)

func collect_rent():
	if 'assigned_room' in attributes:
		resources.coin += 1
		await get_tree().create_timer(1.0).timeout

func prepare_next_day():
	if not 'assigned_room' in attributes:
		queue_free()
		return;

	var room_node = room_mgt.get_room_node(room_number)
	move_to(room_node)

func _process(delta: float) -> void:
	lifetime += delta

	_detect_current_room()
	_handle_task(delta)
	_assign_new_task()

func _detect_current_room():
	current_room = null
	current_room = main.find_in_parents(self, 'room')
	if current_room == null:
		var nodes = main.get_nodes_in_shape(room_detector)
		for node in nodes:
			if node.is_in_group('lobby'):
				current_room = node
				break;

func _handle_task(delta):
	if (current_task == null) or (current_task.is_queued_for_deletion()):
		for task in tasks.get_children():
			if task.is_queued_for_deletion():
				continue
			
			current_task = task
			task.initialize()
			break

	if current_task != null:
		current_task.process_behaviour(delta)

func _assign_new_task():
	if tasks.get_child_count() != 0:
		return

	if attributes.has('assigned_room'):
		append_task('go_to_room')
		return

	if attributes.has('declined_a_room'):
		append_task('leave_motel')
		return

	var hesitate = append_task('hesitate')
	hesitate.duration = HESITATE_DURATION_SECS * randf_range(0.5, 1.5)

	if not attributes.has('assigned_room') and not attributes.has('declined_a_room'):
		var go_to_reception = append_task('go_to_reception')
		go_to_reception.event_script = discuss_stay_event_script
		return

func append_task(task_name):
	return insert_task(tasks.get_child_count(), task_name)

func insert_task(index, task_name):
	print('insert_task: ' + task_name)
	
	var new_task_prefab = task_mgt.get_task_prefab(task_name)
	if new_task_prefab == null:
		return

	var new_task = new_task_prefab.instantiate()
	new_task.task_name = task_name
	tasks.add_child(new_task)
	tasks.move_child(new_task, index)

	if index == 0:
		current_task = null

	return new_task

func clear_tasks():
	for task in tasks.get_children():
		task.queue_free()
	set_state('')

func set_state(new_state):
	state = new_state

func move_guest_toward(node, queue_behind_nodes_with_tasks = [], queue_behind_nodes_in_state = []):	
	movement.move_toward(node, queue_behind_nodes_with_tasks, queue_behind_nodes_in_state)

	if movement.target_movement == 'queued':
		clear_tasks()
		set_state('standing_in_queue')

func get_current_task_name():
	if (current_task == null) or (current_task.is_queued_for_deletion()):
		return null
	return current_task.task_name

func get_current_state():
	if state != '':
		return state
	if movement.target_movement == 'left':
		return 'moving_left'
	if movement.target_movement == 'right':
		return 'moving_right'

	return 'idle'

func move_to(room_node):
	self.reparent(room_node)
	position = Vector2.ZERO
