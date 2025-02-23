extends Sprite2D

@export var snowMovement: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	region_rect.position += snowMovement
