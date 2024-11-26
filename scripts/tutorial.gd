extends Node2D

# Array de pasos del tutorial
var tutorial_steps = [
	{"key": "move_left", "instruction": "Presiona ← para moverte a la izquierda."},
	{"key": "move_right", "instruction": "Presiona → para moverte a la derecha."},
	{"key": "move_up", "instruction": "Presiona ↑ para moverte hacia arriba."},
	{"key": "move_down", "instruction": "Presiona ↓ para moverte hacia abajo."}
]


var current_step = 0 # Paso actual en el tutorial
var character_speed = 200 # Velocidad del personaje

# Referencias a nodos
@onready var instructions_label = $Label
@onready var character = $Player
@onready var label = $VBoxContainer/label
@onready var timer = $VBoxContainer/Timer

func _ready():
	update_instruction()
	label.visible = false # Ocultar el botón al inicio
	timer.stop() # Asegurarse de que el temporizador esté detenido

# Función para actualizar las instrucciones
func update_instruction():
	if current_step < tutorial_steps.size():
		instructions_label.text = tutorial_steps[current_step]["instruction"]
	else:
		instructions_label.text = "¡Completado!"
		label.visible = true # Mostrar el temporizador
		timer.start() # Iniciar el temporizador

func _process(delta):
	# Revisar si el jugador está completando el tutorial
	if current_step < tutorial_steps.size():
		var step = tutorial_steps[current_step]
		var key = step["key"]
		
		if Input.is_action_just_pressed(key):
			# Mover al personaje
			move_character(key, delta)
			
			# Avanzar al siguiente paso
			current_step += 1
			update_instruction()
	
	# Actualizar el texto del temporizador si es visible
	if label.visible:
		label.text = "Inicio de juego: " + str(int(timer.time_left)) + "s"

# Función para mover el personaje
func move_character(key, delta):
	var direction = Vector2.ZERO
	match key:
		"move_left":
			direction = Vector2.LEFT
		"move_right":
			direction = Vector2.RIGHT
		"move_up":
			direction = Vector2.UP
		"move_down":
			direction = Vector2.DOWN
	character.position += direction * character_speed * delta

# Función que se ejecuta al terminar el temporizador
func _on_timer_timeout() -> void:
	timer.stop()  # Detener el temporizador para asegurarse de que no reinicie
	get_tree().change_scene_to_file("res://scenes/laberinto_game.tscn")
