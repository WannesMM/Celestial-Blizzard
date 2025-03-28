extends Cutscene

func _ready() -> void:
	play()

func play():
	AudioEngine.playStory("Story1")
	$AnimationPlayer.play("Intro")

func playWind():
	AudioEngine.playAmbience("Wind",3,7)
	
func stopAudio():
	AudioEngine.stopAudio(3)

func playEthereal():
	AudioEngine.playSFX("Ethereal Dark")
