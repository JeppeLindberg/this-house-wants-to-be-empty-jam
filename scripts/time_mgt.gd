extends Node

@onready var subscriber_mgt = get_node('/root/main/subscriber_mgt')
@onready var event_mgt = get_node('/root/main/event_mgt')
@onready var blackout_anim:AnimationPlayer = get_node('/root/main/blackout/animation')
@onready var events = get_node('/root/main/events')
@onready var clock = get_node('/root/main/clock')



func start_first_day():
	subscriber_mgt.trigger_day_start()
	

func go_to_next_day():
	var _new_week = false

	event_mgt.allow_new_events = false

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

	subscriber_mgt.trigger_day_start()
	blackout_anim.play('fade_out')
	await finished

	event_mgt.allow_new_events = true


