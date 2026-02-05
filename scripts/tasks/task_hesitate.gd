extends Node2D

@onready var main = get_node('/root/main')
@onready var world = get_node('/root/main/world')

var task_name = null
var guest = null

var duration = 1.0
var lifetime = 0.0


func initialize():
	main = get_node('/root/main')
	world = get_node('/root/main/world')
	guest = get_parent().get_parent()

func process_behaviour(delta):
	lifetime += delta

	if lifetime > duration:
		queue_free()
		 