extends Node2D

@onready var subscriber_mgt = get_node('/root/main/subscriber_mgt')
@onready var main = get_node('/root/main')
@onready var resources = get_node('/root/main/resources')


func _ready() -> void:
	add_to_group('helper_phone')

	subscriber_mgt.subscribe_day_end_callables(self, day_end)

func day_end():
	var helpers = main.get_children_in_group(self, 'helper')
	if len(helpers) > 0:
		resources.coin += 1
		await get_tree().create_timer(1.0).timeout

