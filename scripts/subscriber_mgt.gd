extends Node


var day_end_callables = []

func subscribe_day_end_callables(node, callable):
	day_end_callables.append({'node': node, 'callable': callable})

func trigger_day_end():
	for i in range(len(day_end_callables)):
		await day_end_callables[i].callable.call()
		if i < len(day_end_callables) - 1:
			await get_tree().create_timer(1.0).timeout


var day_start_callables = []

func subscribe_day_start_callables(node, callable):
	day_start_callables.append({'node': node, 'callable': callable})

func trigger_day_start():
	for i in range(len(day_start_callables)):
		await day_start_callables[i].callable.call()
