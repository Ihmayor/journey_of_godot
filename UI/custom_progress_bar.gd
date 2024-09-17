extends Control

@export var progress_float: float = 0

var end_point
var start_point


func _ready():
	end_point = %Castle.position
	start_point = %Quill.position

func _on_letter_scroll_line_progress(progress: float):
	var change = (end_point.x - start_point.x) * progress
	%Quill.set_position(Vector2(change, %Quill.position.y)) 
