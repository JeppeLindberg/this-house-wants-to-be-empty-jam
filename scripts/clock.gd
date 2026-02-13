extends Node2D

@onready var hours = get_node('hours')

@export var monday: Node2D
@export var tuesday: Node2D
@export var wednesday: Node2D
@export var thursday: Node2D
@export var friday: Node2D
@export var saturday: Node2D
@export var sunday: Node2D

var weekday = 1
var hour = 0.0

func _process(delta: float) -> void:
	hour += delta
	if hour > 24.0:
		hour = 24.0

	hours.rotation_degrees = (hour / 24.0) * 360.0

	var all_days = [monday, tuesday, wednesday, thursday, friday, saturday, sunday]

	for i in range(len(all_days)):
		if weekday > i + 1:
			all_days[i].state = 'past'
		elif weekday == i + 1:
			all_days[i].state = 'present'
		elif weekday < i + 1:
			all_days[i].state = 'future'
		
