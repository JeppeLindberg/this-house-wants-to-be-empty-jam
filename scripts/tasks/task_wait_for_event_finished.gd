extends Node2D

@onready var main = get_node('/root/main')
@onready var world = get_node('/root/main/world')

var task_name = null
var guest = null

var event = null


func initialize():
	main = get_node('/root/main')
	world = get_node('/root/main/world')
	guest = get_parent().get_parent()

func process_behaviour(_delta):
	if (event == null) or event.is_queued_for_deletion() or (event.is_finished()):
		queue_free()
		 
