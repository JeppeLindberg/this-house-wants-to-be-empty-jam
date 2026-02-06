extends Node2D


@export var coin_text: Label
@export var fervor_text: Label


var coin = 0
var fervor = 0


func _process(_delta: float) -> void:
	coin_text.text = str(coin)
	fervor_text.text = str(fervor)
