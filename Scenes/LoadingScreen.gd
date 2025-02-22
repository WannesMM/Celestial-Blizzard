extends Control

class_name LoadingScreen

var nextScene = "res://Scenes/battlefield.tscn"

func _ready() -> void:
	ResourceLoader.load_threaded_request(nextScene)
	
func _process(delta: float) -> void:
	var progress = []
	ResourceLoader.load_threaded_get_status(nextScene,progress)
	$ProgressBar.text = str(progress[0]*100) + "%"
	
	if progress[0] == 1:
		var scene: PackedScene = ResourceLoader.load_threaded_get(nextScene)
		scene.instantiate()
	
