extends Node2D

@onready var main = get_node('/root/main')
@onready var world = get_node('/root/main/world')

const DISCUSS_STAY_SECS = 3.0

var guest = null

var done_discussing_stay = 0.0


func initialize():
	main = get_node('/root/main')
	world = get_node('/root/main/world')
	guest = get_parent().get_parent()

	done_discussing_stay = guest.lifetime + DISCUSS_STAY_SECS

func process_behaviour(_delta):
	if guest.lifetime > done_discussing_stay:
		guest.room_number = 1
		queue_free()
		 