using Godot;
using System;
using System.IO.Ports;

public partial class ArduinoController : Node2D
{
	private SerialPort _serialPort;
	private CharacterBody2D _player; // Referencia al nodo Player

	public override void _Ready()
	{
		// Configura el puerto serial
		_serialPort = new SerialPort("COM4", 9600);
		_serialPort.Open();

		// Asegúrate de que la escena del jugador está cargada antes de buscar al jugador
		_player = GetTree().Root.GetNode<CharacterBody2D>("Game/Player");
	}
	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if (_serialPort.IsOpen && _serialPort.BytesToRead > 0)
		{
			string command = _serialPort.ReadExisting().Trim();

			Vector2 direction = Vector2.Zero;

			// Traduce el comando en un vector de movimiento
			switch (command)
			{
				case "A": // Izquierda
					direction.X = -1;
					break;
				case "D": // Derecha
					direction.X = 1;
					break;
				case "W": // Arriba
					direction.Y = -1;
					break;
				case "S": // Abajo
					direction.Y = 1;
					break;
			}

			// Aplica la velocidad al jugador
			if (_player != null)
			{
				_player.Velocity = direction * 1500; // Cambia "500" por la velocidad que usas en GDScript
				_player.MoveAndSlide();
			}
		}
	}
	
	// Al salir de la escena, cierra el puerto serial
	public override void _ExitTree()
	{
		if (_serialPort.IsOpen)
			_serialPort.Close();
	}
	
	void _on_area_2d_body_entered(Node smurf){
		GD.Print("Entro");
	}
}
