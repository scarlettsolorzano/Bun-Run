extends CharacterBody2D

# Velocidad del jugador
var speed := 500
var movimiento = true
# Animación del jugador
@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(_delta):
	if movimiento ==false: 
		animated_sprite_2d.play("idle")
		return
	var inputmove = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = inputmove * speed
	move_and_slide()

	# Cambiar animaciones
	if velocity.length() > 0:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
	
	# Cambiar dirección del sprite según el movimiento
	if inputmove.x != 0:
		animated_sprite_2d.flip_h = inputmove.x < 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("chocó")
