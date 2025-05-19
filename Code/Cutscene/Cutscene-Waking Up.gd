extends Cutscene

func _ready() -> void:
	play()

func play():
	super.play()
	$AnimationPlayer.play("Waking Up")

func cinematicBars():
	$CinematicBars.play()

func nextScene():
	super.nextScene()
	Load.callLoadingScreen("res://Scenes/Area/Area_PortForest.tscn")
