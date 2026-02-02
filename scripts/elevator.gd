extends Node2D


@export var floor_1: Node
@export var floor_2: Node


func _ready() -> void:
	add_to_group('elevator')
	add_to_group('room')


