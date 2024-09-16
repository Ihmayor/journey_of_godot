extends Node2D

func _ready():
	%AnimationPlayer.play("fade")
	await %AnimationPlayer.animation_finished
	queue_free()
