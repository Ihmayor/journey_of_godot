extends CanvasLayer

@export var screen_message: String = ""

func _ready():
	%Label.text = screen_message
