extends Control

signal start_game
signal show_credits

func _on_start_button_pressed():
	start_game.emit()

func _on_credits_pressed():
	show_credits.emit()
