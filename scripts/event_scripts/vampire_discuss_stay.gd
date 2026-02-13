extends Node2D

@onready var main = get_node('/root/main')
@onready var room_mgt = get_node('/root/main/room_mgt')

var guest = null

var manuscript = {
	'0': {
		'text_style': '<narration>',
		'text': 'A woman with piercing eyes steps out of the shadows. She approaches Naomi.',
		'buttons': [
			{
				'text': 'Continue',
				'command': 'go_to',
				'param_1': '1'
			}
		]
	},
	'1': {
		'talker_style': '<talker,Vampire>',
		'talker': '???',
		'text': 'Good afternoon, darling.',
		'buttons': [
			{
				'text': 'Continue',
				'command': 'go_to',
				'param_1': '2'
			}
		]
	},
	'2': {
		'talker': 'Naomi',
		'text': 'Hey.',
		'buttons': [
			{
				'text': 'Continue',
				'command': 'go_to',
				'param_1': '3'
			}
		]
	},
	'3': {
		'talker_style': '<talker,Vampire>',
		'talker': '???',
		'text': 'Do you have any rooms free? I would like to have one for a couple of nights.',
		'buttons': [
			{
				'text': 'Allow',
				'command': 'go_to',
				'param_1': 'A1'
			},
			{
				'text': 'Decline',
				'command': 'go_to',
				'param_1': 'B1'
			}
		]
	},
	'A1': {
		'talker': 'Vampire',
		'text': 'Excellent. Do keep in mind that I might be coming and going at odd hours, if you don\'t mind.',
		'buttons': [
			{
				'text': 'Continue',
				'command': 'go_to',
				'param_1': 'A2'
			}
		]
	},
	'A2': {
		'talker': 'Naomi',
		'text': 'Whatever. Just don\'t bother the other guests.',
		'buttons': [
			{
				'text': 'continue',
				'command': 'assign_room_to_guest',
				'finish': true
			}
		]
	},
	'B1': {
		'talker': 'Vampire',
		'text': '... Huh. Keep in mind that I tend to get my way, one way or another.',
		'buttons': [
			{
				'text': 'continue',
				'command': 'decline_guest',
				'finish': true
			}
		]
	}
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
