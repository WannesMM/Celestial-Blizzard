extends Sprite2D

var mouseInside = false
var target_alpha = 0.0  # The desired alpha value
@export var transition_speed: float = 5.0  # Adjust this for faster/slower transition

func _ready() -> void:
	# Ensure the ColorRect starts fully transparent
	modulate.a = 0.0
	visible = true

func mouseEntered():
	mouseInside = true
	target_alpha = 0.5

func mouseExited():
	mouseInside = false
	target_alpha = 0.0

func _process(delta: float) -> void:
	# Smoothly interpolate the current alpha towards the target alpha
	modulate.a = lerp(modulate.a, target_alpha, delta * transition_speed)

func pulseTransparacy():
	pass
