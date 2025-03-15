extends Label

func setText(newText: String):
	if newText != text:
		var fadeTween = create_tween()
		fadeTween.tween_property(self,"modulate:a",0,0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		await fadeTween.finished
		fadeTween.kill()
		visible_ratio = 0
		text = newText
		modulate.a = 1
		var ratioTween = create_tween()
		ratioTween.tween_property(self,"visible_ratio",1,1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		await ratioTween.finished
		ratioTween.kill()
