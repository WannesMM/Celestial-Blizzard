extends Animate

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect.size.y = 0
	play()
	
func play():
	var tween = create_tween()
	AudioEngine.playSFX("Announcement")
	tween.tween_property($ColorRect, "size:y", 54, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	await tween.finished
	tween.kill()
	
	tween = create_tween()
	tween.tween_property($ColorRect, "size:y", 0, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
	await tween.finished
	tween.kill()

func setText(newText):
	$ColorRect/Label.text = newText
