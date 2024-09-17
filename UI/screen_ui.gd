extends Control

signal start_button_pressed
signal pause_button_pressed
signal toggle_music(is_on:bool)


func _input(event):
	if !%StartScreen.visible and event.is_action_pressed("pause"):
		toggle_pause()
		
func show_credits():
	hide_all()
	%CreditsScreen.visible = true

func show_start():
	hide_all()
	%StartScreen.visible = true
	
func show_win():
	hide_all()
	%WinScreen.visible = true
	
func show_game_over():
	hide_all()
	%GameOverScreen.visible = true

func toggle_pause():
	%PauseScreen.visible = !%PauseScreen.visible
	pause_button_pressed.emit()
	
func hide_all():
	for screen in get_children():
		if screen.visible:
			screen.visible = false

func _on_start_screen_show_credits():
	show_credits()

func _on_start_screen_start_game():
	%StartScreen.visible = false
	start_button_pressed.emit()
	
func _on_credits_screen_credits_hide():
	show_start()

func _on_game_game_over(isWin: bool):
	if isWin:
		show_win()
	else:
		show_game_over()

func _on_pause_screen_button_pressed():
	get_tree().reload_current_scene()

func _on_pause_screen_toggle_button_pressed(toggled_on: bool):
	toggle_music.emit(toggled_on)
	#%PlayerAudio._on_screen_control_music_toggle(toggled_on)
	
	
func _on_pause_screen_close():
	pause_button_pressed.emit()
