extends Camera2D

func on_intro_complete(_anim_name: StringName):
	get_parent().visible = false
	queue_free()
