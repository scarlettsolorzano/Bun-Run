extends Area2D

# Escena de la ventana de victoria
@export var victory_window_scene: PackedScene  # Asigna la escena "victoria.tscn" desde el editor

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":  # Asegúrate de que el nodo del jugador se llame "Player"
		# Instanciar la ventana de victoria
		var victory_window = victory_window_scene.instance()

		# Obtener el tiempo transcurrido desde el juego
		var game = get_tree().get_current_scene()
		if game.has_method("get_time_elapsed"):
			var time_elapsed = game.get_time_elapsed()
			if victory_window.has_method("set_time"):
				victory_window.set_time(time_elapsed)

		# Añadir la ventana de victoria como hijo del árbol de nodos
		get_tree().root.add_child(victory_window)

		# Pausar el juego
		get_tree().paused = true
