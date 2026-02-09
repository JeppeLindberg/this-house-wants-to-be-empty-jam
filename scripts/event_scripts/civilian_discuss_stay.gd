extends Node2D

@onready var main = get_node('/root/main')
@onready var room_mgt = get_node('/root/main/room_mgt')

var guest = null

var manuscript = {
	'0': {
		'talker': 'Stranger',
		'text': 'Geez, <wave>what a weather huh?<normal>',
		'buttons': [
			{
				'text': 'continue',
				'command': 'go_to',
				'param_1': '1'
			}
		]
	},
	'1': {
		'talker': 'Stranger',
		'text': 'I am looking for a place to stay. Do you have any space?',
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
		'talker': 'Stranger',
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
		'talker': 'Stranger',
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

func trigger_event_spawned():
	guest.set_state('talking_to_reception')

func trigger_start():
	pass

func trigger_end():
	guest.clear_tasks()

func assign_room_to_guest():
	var assigned_room = room_mgt.assign_random_room()
	guest.room_number = assigned_room.number
	guest.attributes.append('assigned_room')

func decline_guest():
	guest.attributes.append('declined_a_room')
