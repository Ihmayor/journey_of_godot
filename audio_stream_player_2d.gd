#Handle BG Music of Game
extends AudioStreamPlayer2D

@onready var generic : AudioStream = preload("res://music/559067__sunsetplanet__8bittownthemesong.wav")
@onready var copyrighted : AudioStream = preload("res://music/Good Luck, Babe! (8-bit).mp3")

#Secret feature to use hidden song instead of default song
@export var is_copyright : bool  = true

func _ready():
	set_stream(generic)

#Event Listener for whenever the game starts
func _on_game_game_start():
	if is_copyright:
		set_stream(copyrighted)
	else:
		set_stream(generic)
	play()
	
#Event Listener for whenever the music setting is toggled
func _on_screen_control_toggle_music(is_on: bool):
	stream_paused = !is_on
