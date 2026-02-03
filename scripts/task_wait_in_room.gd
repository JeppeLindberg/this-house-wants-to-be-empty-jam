extends Node2D

@onready var main = get_node('/root/main')
@onready var world = get_node('/root/main/world')

const WAIT_IN_ROOM_DURATION = 30.0

var guest = null

var done_wait_in_room = 0.0


func initialize():
	main = get_node('/root/main')
	world = get_node('/root/main/world')
	guest = get_parent().get_parent()

	done_wait_in_room = guest.lifetime + WAIT_IN_ROOM_DURATION

func process_behaviour(_delta):
	pass
	# if guest.lifetime > done_wait_in_room:
	# 	guest.room_number = 1

	# 	guest.insert_task(0,'go_to_entrance')

	# 	queue_free()
		 