extends Area2D

@onready var main = get_node('/root/main')
@onready var mouse_container = get_node('/root/main/mouse_follower/container')
@onready var idle_helpers = get_node('/root/main/idle_helpers')

var return_to_idle = false



func _ready() -> void:
	add_to_group('helper')

func _process(_delta: float) -> void:
	if return_to_idle:
		return_to_idle = false
		idle_helpers.add_helper(self)

func _on_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
	if not visible:
		return
	if main.is_child_of(self, mouse_container):
		return

	if event is InputEventMouseButton:
		if event.pressed:
			click_down()
		elif not event.pressed:
			click_up()

func _input(event):
	if event is InputEventMouseButton and not event.pressed:
		click_up()

func click_down():
	if main.is_child_of(self, idle_helpers) and mouse_container.get_child_count() == 0:
		reparent(mouse_container)
		position = Vector2.ZERO

func click_up():
	if main.is_child_of(self, mouse_container):
		return_to_idle = true

func move_to(node):	
	reparent(node)
	return_to_idle = false
	position = Vector2.ZERO
