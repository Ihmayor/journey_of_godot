extends Node2D

signal game_over(isWin:bool)
signal game_start

func spawn_mob():
	var new_mob = preload("res://characters/slime/mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	
func _on_timer_timeout():
	spawn_mob()

func _on_player_character_health_depleted():
	game_over.emit(false)
	get_tree().paused = true	


func _on_letter_scroll_finish_letter() -> void:
	game_over.emit(true)
	get_tree().paused = true # Replace with function body.


func _on_screen_ui_start_button() -> void:
	%MobTimer.start()
	%InGameUI.visible = true
