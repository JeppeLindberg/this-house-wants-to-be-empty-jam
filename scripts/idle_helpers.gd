extends Node2D

func add_helper(node):
	for child in get_children():
		if child.get_child_count() == 0:
			node.reparent(child)
			node.position = Vector2.ZERO
			return

	push_error('no idle helper slots')

