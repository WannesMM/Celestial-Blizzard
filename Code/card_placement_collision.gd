extends Control

var validPlacement: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_mouse_entered() -> void:
	validPlacement = true

func _on_area_2d_mouse_exited() -> void:
	validPlacement = false

func getValidPlacement():
	return validPlacement
