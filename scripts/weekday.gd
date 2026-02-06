extends Node2D

@export var past_color: Color
@export var present_color: Color
@export var future_color: Color

@onready var visual = get_node('visual')

var state = 'past'


func _process(_delta: float) -> void:
	if state == 'past':
		visual.modulate = past_color
	elif state == 'present':
		visual.modulate = present_color
	elif state == 'future':
		visual.modulate = future_color
	


