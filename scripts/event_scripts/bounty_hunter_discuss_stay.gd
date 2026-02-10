extends Node2D

@onready var main = get_node('/root/main')
@onready var room_mgt = get_node('/root/main/room_mgt')

var guest = null

var manuscript = {
	'0': {
		'text_style': '<narration>',
		'text': 'A man with a grim expression is standing at the counter. His eyes dart around the dark corners of the room, before focusing on Naomi.',
		'buttons': [
			{
				'text': 'Continue',
				'command': 'go_to',
				'param_1': '1'
			}
		]
	},
	'1': {
		'talker': 'Bounty Hunter',
		'text': 'Scotch and a beer.',
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
		'text': 'The bar is down the road bud.',
		'buttons': [
			{
				'text': 'Continue',
				'command': 'go_to',
				'param_1': '3'
			}
		]
	},
	'3': {
		'talker': 'Bounty Hunter',
		'text': 'You mean to tell me that I cannot even get a stiff drink at a motel nowadays?',
		'buttons': [
			{
				'text': 'Continue',
				'command': 'go_to',
				'param_1': '4'
			}
		]
	},
	'4': {
		'talker': 'Naomi',
		'text': 'Dunno, check the vending machine. You have to have a room if you want to use it though, thats the policy',
		'buttons': [
			{
				'text': 'Continue',
				'command': 'go_to',
				'param_1': '5'
			}
		]
	},
	'5': {
		'talker': 'Bounty Hunter',
		'text': 'Fine. Whats the price?',
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
		'talker': 'Bounty Hunter',
		'text': 'Finally.',
		'buttons': [
			{
				'text': 'continue',
				'command': 'assign_room_to_guest',
				'finish': true
			}
		]
	},
	'B1': {
		'talker': 'Bounty Hunter',
		'text': 'Gah, whatever. I\'ll get my drinks elsewhere.',
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
