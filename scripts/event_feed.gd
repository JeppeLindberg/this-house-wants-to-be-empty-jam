extends Node2D

@export var feed_container: VBoxContainer
@export var event_feed_text_prefab: PackedScene
@export var event_feed_button_prefab: PackedScene

var current_script = null
var current_event = null



func _process(_delta: float) -> void:
	visible = feed_container.get_child_count() != 0

func begin_script(event_script, event_source):
	current_script = event_script
	current_event = event_source
	clear()
	current_script.trigger_start()
	go_to('0')

func go_to(denoter):
	for child in feed_container.get_children():
		if child is Button:
			child.disabled = true

	add_text(current_script.manuscript[denoter]['text'])
	for button in current_script.manuscript[denoter]['buttons']:
		add_button(button)

func clear():
	for child in feed_container.get_children():
		child.queue_free()

func add_text(new_text):
	var new_feed_text = event_feed_text_prefab.instantiate()
	new_feed_text.text = new_text
	feed_container.add_child(new_feed_text)

func add_button(new_button_dict):
	var new_button:Button = event_feed_button_prefab.instantiate()
	new_button.text = new_button_dict['text']
	match new_button_dict['command']:
		'go_to':
			new_button.pressed.connect(func(): go_to(new_button_dict['param_1']))
		'assign_room_to_guest':
			new_button.pressed.connect(func(): current_script.assign_room_to_guest())
		'decline_guest':
			new_button.pressed.connect(func(): current_script.decline_guest())
		'finish_event':
			new_button_dict['finish'] = true

	if new_button_dict.get('finish') == true:
		new_button.pressed.connect(func(): 
			clear()
			current_script.trigger_end()
			current_event.queue_free()
		)

	feed_container.add_child(new_button)
