@tool
extends RichTextEffect
class_name RichTextAlpha

# Syntax: [alpha a=1][/alpha]

# Define the tag name.
var bbcode = "alpha"

func _process_custom_fx(char_fx):
	var alpha = char_fx.env.get("a", 1.0)

	char_fx.color.a = alpha
	return true
