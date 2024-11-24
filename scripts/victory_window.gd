extends Control

# Variable para recibir el tiempo transcurrido
var time_taken: float = 0.0

# Configurar el tiempo
func set_time(time: float) -> void:
	time_taken = time
	$Label.text = "¡Tiempo: %.2f segundos!" % time_taken  # Cambia "Label" por el nombre correcto del nodo

func _on_reiniciar_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/laberinto_game.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
