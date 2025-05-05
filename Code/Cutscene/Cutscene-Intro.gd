extends Cutscene

func _ready() -> void:
	play()
	
func play():
	$AnimationPlayer.play("Intro")

func nextScene():
	Random.callLoadingScreen("Title")

func playWind():
	AudioEngine.playAmbience("Wind",3,7)
	
func stopAudio():
	AudioEngine.stopAllAudio()

func playEthereal():
	AudioEngine.playSFX("Ethereal Dark")
