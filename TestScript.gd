extends CanvasLayer
var progress = 0

func _unhandled_key_input(event: InputEvent):
	if event.keycode == KEY_SPACE:
		%CustomProgressBar._on_letter_scroll_line_progress(progress)
	progress += 0.05	
