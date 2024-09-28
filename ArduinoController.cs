using Godot;
using System;
using System.IO.Ports;

public partial class ArduinoController : Node2D
{
	SerialPort serialPort;
	CharacterBody2D player; // Personaje que queremos mover
	Vector2 velocity = Vector2.Zero; // Velocidad del personaje
	
	// Configuración de la velocidad de movimiento
	private float moveSpeed = 3000f;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		// Inicializa el puerto serial
		serialPort = new SerialPort();
		serialPort.PortName = "COM10";
		serialPort.BaudRate = 9600;
		serialPort.Open();

		// Obtén una referencia al personaje (CharacterBody2D)
		player = GetNode<CharacterBody2D>("Player");
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if (!serialPort.IsOpen) return;

		// Limpia la velocidad en cada frame
		velocity = Vector2.Zero;

		// Lee el puerto serial
		string serialMessage = serialPort.ReadExisting();

		// Ajusta la velocidad del personaje dependiendo de la tecla recibida
		switch (serialMessage)
		{
			case "A": // Izquierda
				velocity = new Vector2(moveSpeed, 0);
				break;
			case "D": // Derecha
				velocity = new Vector2(-moveSpeed, 0);
				break;
			case "W": // Arriba
				velocity = new Vector2(0, -moveSpeed);
				break;
			case "S": // Abajo
				velocity = new Vector2(0, moveSpeed);
				break;
			default:
				// Si no recibe ninguna entrada válida, no hace nada
				break;
		}

		// Mueve al personaje con base en la velocidad
		player.Velocity = velocity;
		player.MoveAndSlide();
	}
	
	// Al salir de la escena, cierra el puerto serial
	public override void _ExitTree()
	{
		if (serialPort.IsOpen)
			serialPort.Close();
	}
}
