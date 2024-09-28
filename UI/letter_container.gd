#Handles a scrollable text label that changes format and auto-scrolls
extends PanelContainer

@export var completed_text_color = Color("#de6f33")
@export var awaiting_text_color = Color("#63b057")
@export var unfinished_text_color = Color("#63b057")
@export var incorrect_text_color = Color("#bf2a2a")

@onready var prompt = $RichTextLabel
@onready var prompt_text = prompt.text

signal line_progress(progress:float)
var curr_line : int = 0

func get_prompt() -> String:
	return prompt_text

func set_current_character(current_character_index: int):
	set_prompt_color(completed_text_color, incorrect_text_color, unfinished_text_color, current_character_index)

func set_next_character(next_character_index: int):
	set_prompt_color(completed_text_color, awaiting_text_color, unfinished_text_color, next_character_index)
	#Auto-scroll to line for input
	var line = prompt.get_character_line(next_character_index)
	prompt.scroll_to_line(line)
	
	#Update other elements dependent on scrolling event
	var line_total = prompt.get_line_count()
	if line != curr_line:
		var progress_made = line/(line_total*1.0)
		line_progress.emit(progress_made)
	curr_line = line
	
func set_prompt_color(completed: Color, awaiting: Color, unfinished: Color, next_character_index: int):
	var completed_text = get_bbcode_color_tag(completed) + prompt_text.substr(0, next_character_index) + get_bbcode_end_color_tag()
	var awaiting_text = get_bbcode_color_tag(awaiting) + "[u]" + prompt_text.substr(next_character_index, 1) + "[/u]" + get_bbcode_end_color_tag()
	var unfinished_text = "" 
	if (next_character_index != prompt_text.length()):
		unfinished_text = get_bbcode_color_tag(unfinished) + prompt_text.substr(next_character_index + 1, prompt.text.length() - (next_character_index + 1)) + get_bbcode_end_color_tag()
	prompt.parse_bbcode(completed_text + awaiting_text + unfinished_text)
	
	
func get_bbcode_color_tag(color: Color) -> String:
	return "[color=#" + color.to_html(false) + "]"
	
func get_bbcode_end_color_tag() -> String:
	return "[/color]"
