extends ColorRect

func _ready() -> void:
	scale = Vector2(0,0)

func animateScale(newScale: Vector2):
	var scalar = create_tween().tween_property(self, "scale", newScale, 4).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	await scalar.finished
