@tool
extends RichTextEffect
class_name RichTextColor

# Syntax: [color c=#FFFFFFFF][/color]

# Define the tag name.
var bbcode = "color"

func _process_custom_fx(char_fx):
	var _index = char_fx.env.get("index", 0)
	var color = char_fx.env.get("c", '#555555FF')

	char_fx.color = Color(color)
	return true
