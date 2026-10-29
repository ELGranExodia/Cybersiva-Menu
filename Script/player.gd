extends CharacterBody2D

const SPEED = 200.0
const DASH_SPEED = 600.0
const DASH_DURATION = 0.15

var is_dashing = false
var dash_timer = 0.0
var last_direction = Vector2.RIGHT

# Precargamos la escena del proyectil (asegúrate de crearla y guardarla en esa ruta)
const PROYECTIL = preload("res://esenas/proyectil.tscn")

func _physics_process(delta: float) -> void:
	# 1. Movimiento en 4 direcciones (WASD o Flechas)
	var direction := Input.get_vector("Izquierda", "Derecha", "Arriba", "Abajo")
	print(direction)


	if direction != Vector2.ZERO:
		last_direction = direction.normalized()

	# 2. Control del Dash (Barra espaciadora / ui_accept)
	if Input.is_action_just_pressed("ui_accept") and not is_dashing:
		is_dashing = true
		dash_timer = DASH_DURATION

	if is_dashing:
		velocity = last_direction * DASH_SPEED
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false
	else:
		if direction:
			velocity = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

	# 3. Disparar proyectil hacia el mouse (Click Izquierdo)
	if Input.is_action_just_pressed("Clik_I"): # O usa "ui_select" temporalmente
		disparar()

	# 4. Ataque cuerpo a cuerpo de barrido (Click Derecho)
	if Input.is_action_just_pressed("Clik_D"):
		atacar_barrido()

func disparar() -> void:
	var bala = PROYECTIL.instantiate()
	# Posición inicial del proyectil (desde el centro del jugador)
	bala.global_position = global_position
	
	# Calcular la dirección desde el jugador hasta la posición global del mouse
	var mouse_pos = get_global_mouse_position()
	var direccion_mouse = (mouse_pos - global_position).normalized()
	
	# Pasar la dirección o rotación al proyectil
	bala.rotation = direccion_mouse.angle()
	bala.direccion = direccion_mouse
	
	# Añadir el proyectil a la escena principal (fuera del jugador para que no lo siga)
	get_tree().current_scene.add_child(bala)

func atacar_barrido() -> void:
	print("¡Ataque de barrido cuerpo a cuerpo ejecutado!")
	# Aquí puedes activar un nodo Area2D temporal o una animación de espada/golpe
