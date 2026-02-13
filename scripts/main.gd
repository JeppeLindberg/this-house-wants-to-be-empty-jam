extends Node


@onready var main = get_node('/root/main')
@onready var world = get_node('/root/main/world')
@onready var time_mgt = get_node('/root/main/time_mgt')


func _ready():
	time_mgt.start_first_day()

func get_nodes_in_shape(shape, collision_mask = 0, motion = Vector2.ZERO):
	var temp_shape = PhysicsShapeQueryParameters2D.new()
	temp_shape.shape = shape.shape
	temp_shape.transform = shape.global_transform
	temp_shape.collide_with_areas = true
	if collision_mask != 0:
		temp_shape.collision_mask = collision_mask
	if motion != Vector2.ZERO:
		temp_shape.motion = motion
	var collisions = world.get_world_2d().direct_space_state.intersect_shape(temp_shape);
	if collisions == null:
		return([])
	
	var nodes = []
	for collision in collisions:
		var node = collision['collider']
		nodes.append(node)
	return nodes

var _result

func get_children_in_group(node, group):
	_result = []

	_get_children_in_group_recursive(node, group)

	return _result

func _get_children_in_group_recursive(node, group):
	for child in node.get_children():
		if child.is_queued_for_deletion():
			continue

		if group == '' or child.is_in_group(group):
			_result.append(child)

		_get_children_in_group_recursive(child, group)

func find_in_parents(node, group):
	while node != self:
		node = node.get_parent()
		if node.is_in_group(group):
			return node
		
	return null

func is_child_of(node, parent):
	while node != self:
		node = node.get_parent()
		if node == parent:
			return true
		
	return false
