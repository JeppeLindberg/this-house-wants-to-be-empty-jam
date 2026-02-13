extends Node

@onready var subscriber_mgt = get_node('/root/main/subscriber_mgt')


func _ready() -> void:
	subscriber_mgt.subscribe_day_start_callables(self, prepare_spawns_for_today)


func prepare_spawns_for_today():
	print('bla')

