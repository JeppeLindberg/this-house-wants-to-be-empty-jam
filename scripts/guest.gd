extends Node2D

@onready var main = get_node('/root/main')
@onready var world = get_node('/root/main/world')
@onready var tasks = get_node('tasks')
@onready var guest_mgt = get_node('/root/main/guest_mgt')
@onready var room_detector = get_node('room_detector')
@onready var event_mgt = get_node('/root/main/event_mgt')
@onready var event_scripts = get_node('event_scripts')

var discuss_stay_event_script: Node2D

const MOVE_SPEED = 100.0
const DISCUSS_STAY_SECS = 3.0
const HESITATE_DURATION_SECS = 1.0

var current_task = null
var current_room = null

var room_number = -1

var lifetime = 0.0
var done_discussing_stay = 0.0


func _ready() -> void:
	add_to_group('guest')

	for child in event_scripts.get_children():
		if child.is_in_group('discuss_stay'):
			discuss_stay_event_script = child

func _process(delta: float) -> void:
	var nodes = main.get_nodes_in_shape(room_detector)
	for node in nodes:
		if node.is_in_group('room'):
			current_room = node
			break;

	lifetime += delta

	_handle_task(delta)

	_assign_new_task()

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

	var hesitate = append_task('hesitate')
	hesitate.duration = HESITATE_DURATION_SECS
	if room_number == -1:
		var go_to_reception = append_task('go_to_reception')
		go_to_reception.event_script = discuss_stay_event_script
		return
	if room_number != -1:
		append_task('go_to_room')
		return

func append_task(task_name):
	return insert_task(tasks.get_child_count(), task_name)

func insert_task(index, task_name):
	print(task_name)
	
	var new_task_prefab = guest_mgt.get_task_prefab(task_name)
	if new_task_prefab == null:
		return

	var new_task = new_task_prefab.instantiate()
	tasks.add_child(new_task)
	tasks.move_child(new_task, index)

	if index == 0:
		current_task = null

	return new_task

func move_guest_toward(node, delta):
	global_position.x = move_toward(global_position.x, node.global_position.x, MOVE_SPEED * delta)

func move_to(room_node):
	self.reparent(room_node)
	position = Vector2.ZERO
