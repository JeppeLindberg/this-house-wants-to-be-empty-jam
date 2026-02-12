@tool
extends RichTextEffect
class_name RichTextTalker

# Syntax: [talker index=0 color=#FFFFFF][/talker]

var bbcode = "talker"

func _process_custom_fx(char_fx):
	var _index = char_fx.env.get("index", 0)
	var color = char_fx.env.get("color", '#555555')

	char_fx.color = Color(color)
	return true
