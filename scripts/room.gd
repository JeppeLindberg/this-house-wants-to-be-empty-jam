extends Node2D


@export var number = 0

var attributes = ['available']


func _ready() -> void:
	add_to_group('room')


