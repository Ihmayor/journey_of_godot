extends Control

signal credits_hide

func _on_button_pressed() -> void:
	credits_hide.emit()
