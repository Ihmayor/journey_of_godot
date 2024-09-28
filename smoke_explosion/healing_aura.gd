extends Node2D

@export var NumOfParticlesPerSpawn : int = 3

#create random healing particles 
func spawn_particle():
	var healing_particle = preload("res://smoke_explosion/healing_particle.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	healing_particle.global_position = %PathFollow2D.position
	var new_scale = randf_range(0.2, 0.7)
	healing_particle.scale = Vector2(new_scale, new_scale)
	add_child(healing_particle)

#gap duration between new particles spawning so it's not constant
func _on_timer_timeout():
	for n in NumOfParticlesPerSpawn:
		spawn_particle() 

#stop all random healing particles from spawning after the timer has stopped
func _on_aura_duration_timeout():
	queue_free()
