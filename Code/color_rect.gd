extends ColorRect

var mouseInside = false
var target_alpha = 0.0  # The desired alpha value
@export var transition_speed: float = 5.0  # Adjust this for faster/slower transition

func _ready() -> void:
	# Ensure the ColorRect starts fully transparent
	modulate.a = 0.0
	visible = true

func _on_mouse_entered() -> void:
	mouseInside = true
	target_alpha = 0.5  # Set target alpha to 50% transparency

func _on_mouse_exited() -> void:
	mouseInside = false
	target_alpha = 0.0  # Set target alpha to fully transparent

func _process(delta: float) -> void:
	# Smoothly interpolate the current alpha towards the target alpha
	modulate.a = lerp(modulate.a, target_alpha, delta * transition_speed)
