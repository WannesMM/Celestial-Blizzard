extends Node

func initialize():
	$CelestialBlizzardLogo.modulate.a = 0
	$CelestialBlizzardLogo.scale = Vector2(0.5,0.5)

func play():
	Random.wait(1)
	var scaleTween = create_tween()
	scaleTween.tween_property($CelestialBlizzardLogo, "scale", Vector2(0.7,0.7), 9)
	
	var animationTween = create_tween()
	animationTween.tween_property($CelestialBlizzardLogo, "modulate:a", 1, 2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
	await animationTween.finished
	animationTween.kill()
	Random.wait(2)
	animationTween = create_tween()
	animationTween.tween_property($CelestialBlizzardLogo, "modulate:a", 0, 5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
	await animationTween.finished
	animationTween.kill()
