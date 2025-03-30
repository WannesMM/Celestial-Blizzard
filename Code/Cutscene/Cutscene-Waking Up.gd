extends Cutscene

func _ready() -> void:
	play()

func play():
	$AnimationPlayer.play("Waking Up")

func cinematicBars():
	$CinematicBars.play()

func nextScene():
	Random.callLoadingScreen("Story", "Silent")
