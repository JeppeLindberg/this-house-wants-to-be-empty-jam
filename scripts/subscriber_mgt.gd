extends Node


var day_end_callables = []

func subscribe_day_end_callables(node, callable):
	day_end_callables.append({'node': node, 'callable': callable})

func trigger_day_end():
	for i in range(len(day_end_callables)-1, -1, -1):
		if day_end_callables[i].node == null or day_end_callables[i].node.is_queued_for_deletion():
			day_end_callables.remove_at(i)
			continue;

		await day_end_callables[i].callable.call()			


var day_start_callables = []

func subscribe_day_start_callables(node, callable):
	day_start_callables.append({'node': node, 'callable': callable})

func trigger_day_start():
	for i in range(len(day_start_callables)-1, -1, -1):
		if day_start_callables[i].node == null or day_start_callables[i].node.is_queued_for_deletion():
			day_start_callables.remove_at(i)
			continue;

		await day_start_callables[i].callable.call()
