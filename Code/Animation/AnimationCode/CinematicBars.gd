extends Animate

func _ready() -> void:
	$ColorRect.position = Vector2(0,-341)
	$ColorRect2.position = Vector2(0,684)

func play():
	var move1 := create_tween().tween_property($ColorRect, "position", Vector2(0, -241), 4).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	var move2 := create_tween().tween_property($ColorRect2, "position", Vector2(0, 550), 4).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	await move1.finished

func exitAnimation():
	var move1 := create_tween().tween_property($ColorRect, "position", Vector2(0,-341), 4).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	var move2 := create_tween().tween_property($ColorRect2, "position", Vector2(0,684), 4).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	await move1.finished
	removeSelf()
