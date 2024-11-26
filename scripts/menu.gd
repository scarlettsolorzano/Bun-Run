extends Control

@onready var label = $VBoxContainer/label
	
#Mostrar el texto 
func _process(delta: float) -> void:
	label.text = str(int($VBoxContainer/Timer.time_left))

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
