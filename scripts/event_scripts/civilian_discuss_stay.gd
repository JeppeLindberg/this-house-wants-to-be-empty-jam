extends Node2D

@onready var main = get_node('/root/main')

var guest = null

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
				'text': 'allow',
				'command': 'go_to',
				'param_1': 'A2'
			},
			{
				'text': 'decline',
				'command': 'go_to',
				'param_1': 'B2'
			}
		]
	},
	'A2': {
		'text': 'Thank you.',
		'buttons': [
			{
				'text': 'continue',
				'command': 'assign_room_to_guest',
				'finish': true
			}
		]
	},
	'B2': {
		'text': 'Big mistake, pal.',
		'buttons': [
			{
				'text': 'continue',
				'command': 'decline_guest',
				'finish': true
			}
		]
	},
}


func _ready() -> void:
	add_to_group('discuss_stay')
	
	guest = main.find_in_parents(self, 'guest')

func trigger_finished():
	pass

func assign_room_to_guest():
	guest.room_number = 1
	guest.attributes.append('assigned_room')

func decline_guest():
	guest.attributes.append('declined_a_room')
