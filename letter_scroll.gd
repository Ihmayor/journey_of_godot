extends Node2D

var current_letter_index: int = -1
var has_capslock : bool = false

signal finish_word

signal finish_letter

func start_typing(typed_character: String):
	var prompt = %LetterContents.get_prompt()
	var next_character = prompt.substr(0,1)
	if (next_character == typed_character):
		current_letter_index = 1
		%LetterContents.set_next_character(current_letter_index)

func _unhandled_key_input(event: InputEvent) -> void:
	if not event.is_pressed():
		if event.keycode == KEY_CAPSLOCK:
			has_capslock = !has_capslock
			return
		var unicode = event.keycode
		var has_shift = event.shift_pressed
		
		if not has_shift && not has_capslock:
			unicode = event.keycode | 0x20
		else:
			unicode = event.keycode

		var input_char = null
		if unicode > 20 and unicode < 40_000: #Filters out control characters
			input_char = String.chr(unicode)
		elif event.keycode == KEY_ENTER:
			input_char = "\n"
		else:
			print("invalid code")
			return
		input_char = handle_special_characters(input_char, has_shift)
		print(input_char)
		if current_letter_index == -1:
			start_typing(input_char)
			return
			
		var prompt = %LetterContents.get_prompt()
		var next_character = prompt.substr(current_letter_index, 1)
		
		if input_char == next_character:
			if next_character == " " or next_character == "/n":
				finish_word.emit()
			current_letter_index += 1
			%LetterContents.set_next_character(current_letter_index)
			if current_letter_index == prompt.length():
				finish_letter.emit()
				current_letter_index = -1
		


#Hardcoded to specific english keyboard layout.
#TODO: Would like to find the unicode => string equivalent for special characters
func handle_special_characters(character: String, has_shift: bool) -> String:
	if not has_shift:
		return character
	if character == "'":
		character = "\""
	elif character == ";":
		character = ":"
	elif character == ".":
		character = ">"
	elif character == ",":
		character = "<"
	elif character == "\\":
		character = "|"
	elif character == "0":
		character = ")"
	elif character == "1":
		character = "!"
	elif character == "2":
		character = "@"
	elif character == "3":
		character = "#"
	elif character == "4":
		character = "$"
	elif character == "5":
		character = "%"
	elif character == "6":
		character = "^"
	elif character == "7":
		character = "&"
	elif character == "8":
		character = "*"
	elif character == "9":
		character = "("
	elif character == "/":
		character = "?"
	return character
