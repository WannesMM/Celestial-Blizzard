extends Animate
var text

func _ready() -> void:
	modulate.a = 0
	
func play():
	await fadeIn()
	var tween = create_tween()
	AudioEngine.playSFX("SoundEffect01")
	await $Label.setText(text)
	await Random.wait(1)
	await fadeOut()

func setText(newText: String):
	text = newText
