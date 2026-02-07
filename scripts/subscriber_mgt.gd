extends Node


var day_end_callables = []

func subscribe_day_end_callables(node, callable):
	day_end_callables.append({'node': node, 'callable': callable})

func trigger_day_end():
	for i in range(len(day_end_callables)):
		await day_end_callables[i].callable.call()
		if i < len(day_end_callables) - 1:
			await get_tree().create_timer(1.0).timeout
