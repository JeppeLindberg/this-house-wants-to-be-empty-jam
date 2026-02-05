extends Node2D

@onready var main = get_node('/root/main')

var manuscript = {
	'0': {
		'text': 'hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello',
		'buttons': [
			{
				'text': 'continue',
				'command': 'go_to',
				'param_1': '1'
			}
		]
	},
	'1': {
		'text': 'hello hello hello hello hello hello hello hello hello hello hello',
		'buttons': [
			{
				'text': 'continue',
				'command': 'finish_event'
			}
		]
	},
}


func _ready() -> void:
	add_to_group('discuss_stay')

func trigger_finished():
	var guest = main.find_in_parents(self, 'guest')
	print(guest)
	guest.room_number = 1
