extends Node

@onready var main = get_node('/root/main')
@onready var subscriber_mgt = get_node('/root/main/subscriber_mgt')
@onready var world = get_node('/root/main/world')


@export var bounty_hunter_prefab: PackedScene
@export var vampire_prefab: PackedScene

@export var delayed_spawner_prefab: PackedScene


func _ready() -> void:
	subscriber_mgt.subscribe_day_start_callables(self, prepare_spawns_for_today)

func prepare_spawns_for_today():
	var entrance = main.get_children_in_group(world,'entrance')[0]
	var _floor = main.find_in_parents(entrance, 'floor')
	var possible_spawns = [bounty_hunter_prefab, vampire_prefab]
	possible_spawns.shuffle()
	var possible_hours = range(10)
	possible_hours.shuffle()

	for i in range(2):
		var new_spawner = delayed_spawner_prefab.instantiate()
		var new_guest = possible_spawns.pop_front().instantiate()
		new_spawner.add_child(new_guest)
		_floor.add_child(new_spawner)
		new_spawner.global_position = entrance.global_position
		new_spawner.call_deferred('spawn_at_hour', possible_hours.pop_front())
