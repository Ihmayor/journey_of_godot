extends "res://UI/in_game_screen.gd"
#Extends in game screen with additional buttons

signal toggle_button_pressed(toggled_on: bool)
signal button_pressed
signal close_pressed

@export var toggle_name : String 
@export var button_name : String 

func _ready():
	%CheckButton.text = toggle_name
	%CheckButton.button_pressed = true
	%Button.text = button_name

func _on_check_button_toggled(toggled_on: bool):
	toggle_button_pressed.emit(toggled_on)

func _on_button_pressed():
	button_pressed.emit()

func _on_close_pressed():
	close_pressed.emit()
	visible = false
