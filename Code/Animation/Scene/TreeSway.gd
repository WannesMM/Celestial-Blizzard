extends Sprite3D

@export var wind_strength: float = 0.2
@export var wind_speed: float = 1.0

var time_offset: float

func _ready():
	time_offset = randf() * 10.0  # Randomize wind per tree

func _process(delta):
	var sway = sin(Time.get_ticks_msec() / 1000.0 * wind_speed + time_offset) * wind_strength
	transform.origin.x += sway * 0.1
