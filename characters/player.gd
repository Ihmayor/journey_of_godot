extends CharacterBody2D

var speed = 500
var mouse_position = null
var is_moving : bool = false
var health = MAX_HEALTH
const MAX_HEALTH = 100.0

signal health_depleted

func _physics_process(delta):
	check_damage(delta)
	handle_mouse_move()
		
	
func handle_mouse_move():
	if not is_moving: 
		%HappyBoo.play_idle_animation()
		return
	mouse_position =  get_global_mouse_position()
	var diff = (position - mouse_position).length()
	if ( diff > 20):
		var direction = (mouse_position - position).normalized()
		velocity = (direction * speed)
		move_and_slide()
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	

func check_damage(delta: float):
	var overlapping_mobs = %DamageBox.get_overlapping_bodies()
	const DAMAGE_RATE = 5.0
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()
	


func _input(event):
	if event.is_action_pressed("forward"):
		is_moving = true	
	if event.is_action_released("forward"):
		is_moving = false	

func handle_keyboard_move(event:InputEvent):
	#Write movement to do tab mode instead
	pass

func _on_letter_scroll_finish_word():
	const HEAL_RATE = 7.0
	if health < MAX_HEALTH:
		health += HEAL_RATE
	else:
		var healing_aura = preload("res://smoke_explosion/healing_aura.tscn").instantiate()
		add_child(healing_aura)
		health += HEAL_RATE
	%ProgressBar.value = health
