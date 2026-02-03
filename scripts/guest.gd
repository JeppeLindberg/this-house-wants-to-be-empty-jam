extends Node2D

@onready var main = get_node('/root/main')
@onready var world = get_node('/root/main/world')
@onready var tasks = get_node('tasks')
@onready var guest_mgt = get_node('/root/main/guest_mgt')
@onready var room_detector = get_node('room_detector')

const MOVE_SPEED = 100.0
const DISCUSS_STAY_SECS = 3.0

var current_task = null
var current_room = null

var room_number = -1

var lifetime = 0.0
var done_discussing_stay = 0.0


func _ready() -> void:
	insert_task(0, 'go_to_reception')

func _process(delta: float) -> void:
	var nodes = main.get_nodes_in_shape(room_detector)
	for node in nodes:
		if node.is_in_group('room'):
			current_room = node
			break;

	lifetime += delta

	if (current_task == null) or (current_task.is_queued_for_deletion()):
		for task in tasks.get_children():
			if task.is_queued_for_deletion():
				continue
			
			current_task = task
			task.initialize()
			break

	if current_task != null:
		current_task.process_behaviour(delta)

func insert_task(index, task_name):
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

