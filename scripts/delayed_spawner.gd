extends Node2D

@onready var clock = get_node('/root/main/clock')



func _ready() -> void:
	add_to_group('disabled')
	visible = false

func spawn_at_hour(hour):
	while true:
		if clock != null and clock.hour > hour:
			spawn()
			return
		await get_tree().create_timer(0.1).timeout

func spawn():
	for child in get_children():
		child.reparent(get_parent())

	queue_free()
