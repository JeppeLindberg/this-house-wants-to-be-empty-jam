@tool
extends RichTextEffect
class_name RichTextName

# Syntax: [name index=0 color=#FFFFFFFF][/name]

# Define the tag name.
var bbcode = "name"

func _process_custom_fx(char_fx):
	var _index = char_fx.env.get("index", 0)
	var color = char_fx.env.get("color", '#555555FF')

	char_fx.color = Color(color)
	return true
