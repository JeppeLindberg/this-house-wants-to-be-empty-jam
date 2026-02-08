extends Node2D

@onready var floor_mgt = get_node('/root/main/floor_mgt')
@onready var subscriber_mgt = get_node('/root/main/subscriber_mgt')

@export var floor_1: Node
@export var floor_2: Node

var floor_queue = []
var lifetime = 0.0
var wait_until = 0.0

const ELEVATOR_SPEED = 80.0
const WAIT_SECONDS = 1.0


func _ready() -> void:
	add_to_group('elevator')

	subscriber_mgt.subscribe_day_start_callables(self, prepare_next_day)

func prepare_next_day():
	floor_queue = []
	move_to(floor_mgt.get_floor_node([1, 2].pick_random()))
	position = Vector2.ZERO

func call_to_floor(floor_number):
	floor_queue.append(floor_number)

func _process(delta: float) -> void:
	lifetime += delta

	if lifetime < wait_until:
		return

	if floor_queue != []:
		var target_pos = floor_mgt.get_floor_node(floor_queue[0]).global_position
		global_position = global_position.move_toward(target_pos, ELEVATOR_SPEED * delta)
		if global_position == target_pos:
			move_to(floor_mgt.get_floor_node(floor_queue[0]))
			floor_queue.pop_front()
			wait_until = lifetime + WAIT_SECONDS


func move_to(floor_node):
	self.reparent(floor_node)

func current_floor():
	if get_parent() == floor_1:
		return 1
	if get_parent() == floor_2:
		return 2
