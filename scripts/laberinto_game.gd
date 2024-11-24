extends Node2D

@onready var timer = $Timer  # Asegúrate de tener un nodo Timer en tu escena

var time_elapsed: float = 0.0

func _ready() -> void:
	timer.start()

func _process(delta: float) -> void:
	time_elapsed += delta

func get_time_elapsed() -> float:
	return time_elapsed
