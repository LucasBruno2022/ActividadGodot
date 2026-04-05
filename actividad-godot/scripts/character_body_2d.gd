extends CharacterBody2D


var SPEED: int = 10
var max_speed: int = 500
var saltar: int = -500
var max_saltar: int = 2
var saltos_actual: int = 0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_floor():
		saltos_actual = 0
		
	
	if Input.is_action_just_pressed("espacio") and saltos_actual < max_saltar:
		velocity.y = saltar
		saltos_actual += 1
	
	var direction = Input.get_axis("izquierda", "derecha")
	if direction:
		velocity.x += direction * SPEED
	else: 
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	
	if Input.is_action_just_pressed("abajo") and is_on_floor():
		set_collision_mask_value(2, false)
		await get_tree().create_timer(0.7).timeout
		set_collision_mask_value(2, true)
		
	move_and_slide()
	
