extends Control

signal start_button

func show_credits():
	hide_all()
	%credits_screen.visible = true
func show_start():
	hide_all()
	%start_screen.visible = true
	
func show_win():
	hide_all()
	%win_screen.visible = true
	
func show_game_over():
	hide_all()
	%game_over.visible = true

func hide_all():
	for screen in get_children():
		if screen.visible:
			screen.visible = false

func _on_start_screen_show_credits():
	show_credits()

func _on_start_screen_start_game():
	%start_screen.visible = false
	start_button.emit()


func _on_game_game_over(isWin: bool):
	if isWin:
		show_win()
	else:
		show_game_over()

func _on_credits_screen_credits_hide():
	show_start()
