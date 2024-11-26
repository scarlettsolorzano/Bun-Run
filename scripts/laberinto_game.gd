extends Node2D

signal iniciarTimer 

func _ready() -> void:
	$Player.movimiento = true

func _on_zanahoria_body_entered(body: Node2D) -> void:
	if body == $Player:
		$CanvasLayer.visible= true 
		iniciarTimer.emit()
		$Player.movimiento = false
