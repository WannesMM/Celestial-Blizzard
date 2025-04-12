extends Cutscene
var followingCutscene = preload("res://Scenes/Cutscenes/Waking Up.tscn")

func _ready() -> void:
	play()
	
func play():
	$AnimationPlayer.play("Intro")

func nextScene():
	get_tree().change_scene_to_packed(followingCutscene)

func playWind():
	AudioEngine.playAmbience("Wind",3,7)
	
func stopAudio():
	AudioEngine.stopAllAudio()

func playEthereal():
	AudioEngine.playSFX("Ethereal Dark")
