extends Node

@onready var subscriber_mgt = get_node('/root/main/subscriber_mgt')
@onready var blackout_anim:AnimationPlayer = get_node('/root/main/blackout/animation')
@onready var events = get_node('/root/main/events')
@onready var clock = get_node('/root/main/clock')

var between_days = false



func start_first_day():
	subscriber_mgt.trigger_prepare_next_day()
	

func go_to_next_day():
	var _new_week = false

	between_days = true

	for event in events.get_children():
		event.queue_free()

	await subscriber_mgt.trigger_day_end()

	blackout_anim.play('fade_in')
	var finished = blackout_anim.animation_finished
	await finished

	clock.weekday += 1	
	if clock.weekday > 7:
		_new_week = true
		clock.weekday = 1
	clock.hour = 0.0

	subscriber_mgt.trigger_prepare_next_day()

	blackout_anim.play('fade_out')
	await finished

	await subscriber_mgt.trigger_day_start()

	between_days = false


