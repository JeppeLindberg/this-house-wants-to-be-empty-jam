extends RichTextLabel


var _normal_tag = '<normal>'

var extra_effects = \
{
	'<normal>': '@',
	'<narration>': '[color c=#AAAAAA]@[/color]',
	'<wave>': '[custom_wave index=%]@[/custom_wave]',
	'<name,Naomi>': '[name color=#559955 index=%]@[/name]',
	'<name,Stranger>': '[name color=#555599 index=%]@[/name]',
	'<name,Bounty Hunter>': '[name color=#995555 index=%]@[/name]'
}

var all_symbols_visible = false
var _raw = ''
var _symbols_progress = 0.0


func _ready() -> void:
	install_effect(RichTextAlpha.new())
	install_effect(RichTextColor.new())
	install_effect(RichTextCustomWave.new())
	install_effect(RichTextName.new())

func set_normal_tag(new_normal_tag):
	if new_normal_tag != '':
		_normal_tag = new_normal_tag

func set_text_raw(raw, symbols = 0):
	all_symbols_visible = false
	_raw = raw
	_symbols_progress = float(symbols)

	text = _raw_to_bb(_raw, 0)

func progress_symbols(delta):
	_symbols_progress += delta

	text = _raw_to_bb(_raw, int(_symbols_progress))

func _raw_to_bb(raw, symbols):
	var output = ''
	var raw_index = 0
	var bb_index = 0
	var current_extra_effect = _normal_tag
	var free_symbol = false

	while raw_index < len(raw):
		if raw[raw_index] == ' ':
			output += ' '
			raw_index += 1

		for effect in extra_effects.keys():
			if raw.substr(raw_index).begins_with(effect):
				raw_index += len(effect)
				current_extra_effect = effect

		free_symbol = 'name' in current_extra_effect

		if raw_index < len(raw):
			var next_output = raw[raw_index]

			next_output = _add_extra_effect(current_extra_effect, bb_index, next_output)

			if free_symbol:
				symbols += 1
			
			if bb_index < symbols:
				next_output = _add_alpha(1, next_output)
			else:			
				next_output = _add_alpha(0, next_output)
		
			output += next_output

		raw_index += 1
		bb_index += 1
		
	if bb_index < symbols:
		all_symbols_visible = true
	
	return output

func _add_extra_effect(tag, index, tex):
	return extra_effects[tag].replace('%', str(index)).replace('@', tex)

func _add_alpha(alpha, tex):
	return '[alpha a=%]@[/alpha]'.replace('%', str(alpha)).replace('@', tex)
