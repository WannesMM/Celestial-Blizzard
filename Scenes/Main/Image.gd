extends Sprite2D

var currentImage: String = ""

func setPortraitImage(image:String, pos: Vector2, scalar: Vector2):
	if currentImage != image:
		var fadeTween = create_tween()
		fadeTween.tween_property(self,"modulate:a",0,0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		await fadeTween.finished
		fadeTween.kill()
		
		currentImage = image
		texture = load(image)
		position = pos
		scale = scalar
		
		fadeTween = create_tween()
		fadeTween.tween_property(self,"modulate:a",1,0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		await fadeTween.finished
		fadeTween.kill()
