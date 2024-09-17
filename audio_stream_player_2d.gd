extends AudioStreamPlayer2D

@onready var generic : AudioStream = preload("res://music/559067__sunsetplanet__8bittownthemesong.wav")
@onready var copyrighted : AudioStream = preload("res://music/Good Luck, Babe! (8-bit).mp3")

@export var is_copyright : bool  = true

func _ready():
	set_stream(generic)

func _on_game_game_start():
	if is_copyright:
		set_stream(copyrighted)
	else:
		set_stream(generic)
	play()
	

func _on_screen_control_toggle_music(is_on: bool):
	stream_paused = !is_on
