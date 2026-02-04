extends Node2D

@onready var main = get_node('/root/main')

var manuscript = [
	'hello',
	'how are you'
]


func _ready() -> void:
	add_to_group('discuss_stay')

func trigger_finished():
	var guest = main.find_in_parents(self, 'guest')
	print(guest)
	guest.room_number = 1
