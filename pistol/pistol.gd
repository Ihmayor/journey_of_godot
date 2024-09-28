extends Area2D

var has_autofire : bool = false

func _physics_process(_delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)
		
func _input(event):
	if event.is_action_pressed("shoot"):
		shoot()
	if event.is_action_pressed("toggle_autofire"):
		has_autofire = !has_autofire

#Weapon Shoot Event. Instantiates projectile element
func shoot():
	const BULLET = preload("res://pistol/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)

#Toggleable auto-fire component to trigger shooting at a certain duration
func _on_auto_fire_timeout():
	if has_autofire:
		shoot()
