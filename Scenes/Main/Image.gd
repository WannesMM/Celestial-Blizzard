extends Sprite2D

var currentImage: String = ""

func setPortraitImage(image:String, pos: Vector2 = Vector2(0,0), scalar: Vector2 = Vector2(1,1)):
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

func setImage(newTexture: Texture, pos: Vector2 = Vector2(0,0), scalar: Vector2 = Vector2(1,1)):
	texture = newTexture
	position = pos
	scale = scalar

var scroll = true
func startScroll():
	scroll = true
	var originalPos = position
	var energyTween
	while scroll == true:
		energyTween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		energyTween.tween_property(self,"position",position + Vector2(100,0),20)
		await energyTween.finished
		energyTween.stop()
		energyTween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		energyTween.tween_property(self,"position",originalPos,20)
		await energyTween.finished
		energyTween.stop()

func stopScroll():
	scroll = false

func modulateV(vValue: float, duration: float = 1):
	var mTween = create_tween()
	mTween.tween_property(self, "modulate:v", vValue, duration)
	await mTween.finished
	mTween.kill

func selfModulateV(vValue: float, duration: float = 1):
	var mTween = create_tween()
	mTween.tween_property(self, "self_modulate:v", vValue, duration)
	await mTween.finished
	mTween.kill

func fade(aValue: float, duration: float = 1):
	var mTween = create_tween()
	mTween.tween_property(self, "modulate:a", aValue, duration)
	await mTween.finished
	mTween.kill

func flash():
	modulate.v = 1
	await modulateV(0)
