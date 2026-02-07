extends Node

@onready var subscriber_mgt = get_node('/root/main/subscriber_mgt')
@onready var blackout_anim:AnimationPlayer = get_node('/root/main/blackout/animation')



func go_to_next_day():
	await subscriber_mgt.trigger_day_end()
	blackout_anim.play('fade_in')
	var finished = blackout_anim.animation_finished
	await finished
	subscriber_mgt.trigger_day_start()
	blackout_anim.play('fade_out')
	await finished


