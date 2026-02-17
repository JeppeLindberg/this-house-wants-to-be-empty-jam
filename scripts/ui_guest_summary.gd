extends PanelContainer

@export var text: RichTextLabel

var guest = null

var summary_template = '%1

Day end: +1 coin

%2';


func update_guest_summary():
	if guest == null:
		return
	
	var traits = guest.traits.get_children()
	var trait_names = []
	for trait_node in traits:
		trait_names.append('<trait>' + trait_node.trait_name + '<normal>')

	var traits_text = '\n'.join(trait_names)

	text.set_text_raw(summary_template.replace('%1', guest.guest_name).replace('%2', traits_text));
