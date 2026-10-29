extends Area2D

const VELOCIDAD = 500.0
var direccion = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if direccion != Vector2.ZERO:
		global_position += direccion * VELOCIDAD * delta

# Opcional: Destruir la bala si choca con algo o sale de la pantalla
func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player": # Evita que choque con el propio jugador
		queue_free() # Borra el proyectil
