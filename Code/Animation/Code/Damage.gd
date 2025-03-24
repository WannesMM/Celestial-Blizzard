extends Animate

func _ready() -> void:
	modulate.a = 0
	$Node2D/GPUParticles2D.emitting = false
	$Node2D/PortraitScaler/PortraitMask/PortraitSprite.modulate.v = 0
	play()
	
func play():
	modulate.a = 1
	$Node2D/GPUParticles2D.emitting = true
	$Node2D/PortraitScaler/PortraitMask/PortraitSprite.flash()
	await Random.wait(0.5)
	$Node2D/GPUParticles2D.emitting = false
	await fadeOut()
	removeSelf()
	
func setText(newText: String):
	$Node2D/Label.text = newText

func setPosition(pos: Vector2):
	$Node2D.global_position = pos
