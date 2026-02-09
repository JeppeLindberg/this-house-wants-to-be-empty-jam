@tool
extends RichTextEffect
class_name RichTextCustomWave

# Syntax: [custom_wave index=0 amp=50.0 freq=5.0][/custom_wave]

# Define the tag name.
var bbcode = "custom_wave"

func _process_custom_fx(char_fx):
	# Get parameters, or use the provided default value if missing.
	var index = char_fx.env.get("index", 0)
	var amp = char_fx.env.get("amp", 5.0)
	var freq = char_fx.env.get("freq", 3.0)

	var vertical_movement = amp * sin(float(index) * 0.1 + _curr_secs() * freq)
	char_fx.offset.y += vertical_movement
	return true

	

func _curr_secs():
	return float(Time.get_ticks_msec()) / 1000.0;
