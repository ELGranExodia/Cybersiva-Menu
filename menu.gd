extends Control

# Ruta correcta a tu AnimationPlayer basado en tu panel de escena
@onready var animacion = $fadetoblack

func _ready() -> void:
	# Conectamos los botones a sus respectivas funciones limpias
	
	%Exit.pressed.connect(_on_exit_pressed)

func _on_play_pressed() -> void:
	# 1. Reproducir la animación de transición
	animacion.play("FundidoANegro")
	
	# 2. Esperar a que la animación termine
	await animacion.animation_finished
	
	# 3. Cambiar a la escena del juego
	get_tree().change_scene_to_file("res://esenas/main.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
