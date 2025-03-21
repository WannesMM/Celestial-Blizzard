extends Animate

func _ready() -> void:
	modulate.a = 0
	$Control/Node2D/GPUParticles2D.emitting = false
	$Control/Node2D/PortraitScaler/PortraitMask/PortraitSprite.modulate.v = 0
	$Control/Node2D/Label.text = ""
	play()
	
func play():
	modulate.a = 1
	$Control/Node2D/GPUParticles2D.emitting = true
	$Control/Node2D/PortraitScaler/PortraitMask/PortraitSprite.flash()
	await Random.wait(0.5)
	$Control/Node2D/GPUParticles2D.emitting = false
	await fadeOut()
	removeSelf()
	
func setText(newText: String):
	$Control/Node2D/Label.text = newText

func setPosition(pos: Vector2):
	$Control/Node2D.global_position = pos
