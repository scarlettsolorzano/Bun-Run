extends Control

# Botones y texto
@onready var label = $label
@onready var timer = $Timer


func _process(delta):
	if timer.time_left < 10:
		label.text = "Reiniciar juego: " + str(int($Timer.time_left))


func _on_game_iniciar_timer() -> void:
	timer.start()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/laberinto_game.tscn")
