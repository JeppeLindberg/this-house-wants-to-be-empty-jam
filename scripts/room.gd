extends Node2D

@onready var helper_interactable = get_node('helper_interactable')
@onready var subscriber_mgt = get_node('/root/main/subscriber_mgt')

@export var number = 0
@export var starts_out_of_order = false

@export_category('Packed scene')
@export var out_of_order_visual: Node2D

var attributes = []


func _ready() -> void:
	add_to_group('room')

	subscriber_mgt.subscribe_day_start_callables(self, day_start)

	if starts_out_of_order:
		attributes.append('out_of_order')
	else:
		attributes.append('available')

	update()

func update():
	if 'out_of_order' in attributes:
		helper_interactable.set_enabled(true)
		out_of_order_visual.visible = true
	else:
		helper_interactable.set_enabled(false)
		out_of_order_visual.visible = false

func day_start():
	if helper_interactable.has_worker():
		await get_tree().create_timer(0.5).timeout

		if 'out_of_order' in attributes:
			attributes.erase('out_of_order')
			attributes.append('available')

		update()

		await get_tree().create_timer(0.5).timeout
