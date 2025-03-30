extends WorldEnvironment

@export var rotateS: bool = false

func _process(delta: float) -> void:
	if rotateS:
		environment.sky_rotation.y += 0.00005

func rotateSky():
	rotateS = !rotateS
