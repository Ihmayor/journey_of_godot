extends Node2D

signal game_over(isWin:bool)
signal game_start

var is_paused : bool = false

func spawn_mob():
	var new_mob = preload("res://characters/slime/mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	
func _on_timer_timeout():
	spawn_mob()

func _input(event):
	if event.is_action_pressed("secret"):
		%PlayerAudio.is_copyright = true

func _on_player_character_health_depleted():
	game_over.emit(false)
	get_tree().paused = true	


func _on_letter_scroll_finish_letter() -> void:
	game_over.emit(true)
	get_tree().paused = true # Replace with function body.


func _on_screen_ui_start_button():
	get_tree().paused = false
	%ScreenUI.visible = false
	%CutScene.visible = true
	%PlayerCharacter.visible = false
	%CutSceneAnimationPlayer.play("intro_animation")

func start_game_loop():
	%MobTimer.start()
	%InGameUI.visible = true
	get_tree().paused = false
	game_start.emit()
	
func pause_game():
	if %CutScene.visible:
		if %CutSceneAnimationPlayer.is_playing():
			%CutSceneAnimationPlayer.pause()
		else:
			%CutSceneAnimationPlayer.play()
	elif %InGameUI.visible:
		get_tree().paused = !get_tree().paused

func _on_intro_scene_complete(_anim_name: StringName):
	start_game_loop()
