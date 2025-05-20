extends Cutscene

func play():
	super.play()
	$AnimationPlayer.play("Waking Up")

func cinematicBars():
	$CinematicBars.play()

func nextScene():
	super.nextScene()
	Load.callLoadingScreen("res://Scenes/Main/MainScreen.tscn")
