extends Camera3D

var cameraInputDirection: Vector2 = Vector2.ZERO
@export_range(0.0,1.0) var mouseSensitivity: float = 1

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		print(event.position)
		cameraInputDirection = event.screen_relative * mouseSensitivity
