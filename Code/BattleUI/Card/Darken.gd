extends Sprite2D

var mouseInside = false
var target_alpha = 0.0  # The desired alpha value
var transition_speed: float = 5.0  # Adjust this for faster/slower transition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0.0
	visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Smoothly interpolate the current alpha towards the target alpha
	modulate.a = lerp(modulate.a, target_alpha, delta * transition_speed)

func darken():
	target_alpha = 0.5
	
func undoDarken():
	target_alpha = 0
	
