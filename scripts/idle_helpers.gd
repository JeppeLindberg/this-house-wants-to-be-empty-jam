extends Node2D

@onready var subscriber_mgt = get_node('/root/main/subscriber_mgt')
@onready var clock = get_node('/root/main/clock')

@export var helper_prefab: PackedScene


func _ready() -> void:
	subscriber_mgt.subscribe_day_start_callables(self, day_start)
	

func day_start():
	if clock.weekday % 3 == 0:
		await get_tree().create_timer(0.5).timeout
		var new_helper = helper_prefab.instantiate()
		add_child(new_helper)
		add_helper(new_helper)
		await get_tree().create_timer(0.5).timeout


func add_helper(node):
	for child in get_children():
		if child.get_child_count() == 0:
			node.reparent(child)
			node.position = Vector2.ZERO
			return

	push_error('no idle helper slots')

