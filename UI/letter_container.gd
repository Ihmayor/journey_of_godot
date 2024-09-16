extends PanelContainer

@export var completed_text_color = Color("#de6f33")
@export var awaiting_text_color = Color("#63b057")
@export var unfinished_text_color = Color("#63b057")

@onready var prompt = $RichTextLabel
@onready var prompt_text = prompt.text

func get_prompt() -> String:
	return prompt_text

func set_next_character(next_character_index: int):
	var blue_text = get_bbcode_color_tag(completed_text_color) + prompt_text.substr(0, next_character_index) + get_bbcode_end_color_tag()
	var green_text = get_bbcode_color_tag(awaiting_text_color) + prompt_text.substr(next_character_index, 1) + get_bbcode_end_color_tag()
	var red_text = "" 
	if (next_character_index != prompt_text.length()):
		red_text = get_bbcode_color_tag(unfinished_text_color) + prompt_text.substr(next_character_index + 1, prompt.text.length() - (next_character_index + 1)) + get_bbcode_end_color_tag()
	prompt.parse_bbcode(blue_text + green_text + red_text)
	var line = prompt.get_character_line(next_character_index)
	prompt.scroll_to_line(line)
	
func get_bbcode_color_tag(color: Color) -> String:
	return "[color=#" + color.to_html(false) + "]"
	
func get_bbcode_end_color_tag() -> String:
	return "[/color]"
