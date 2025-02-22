extends Control

class_name LoadingScreen

var nextScene: PackedScene = "res://Scenes/battlefield.tscn"
var loadStatus = 0
var loadProgress: Array[float] = []

func startLoading(scene: PackedScene):
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		#nextScene = scene
		ResourceLoader.load_threaded_request(nextScene.resource_path)
	

func _process(delta):
	# Get loading progress
	if nextScene == null:
		return
	loadStatus = ResourceLoader.load_threaded_get_status(nextScene.resource_path, loadProgress)
	
	print(floor(loadProgress[0] * 100))
	$ProgressBar.text = str(floor(loadProgress[0] * 100)) + "%"
	if loadStatus == ResourceLoader.THREAD_LOAD_LOADED:
		print("Loaded new screen")
		var newScene = ResourceLoader.load_threaded_get(nextScene.resource_path)
		get_tree().change_scene_to_packed(newScene)
		

func _ready():
	$ProgressBar.text = str(0)  # Reset progress
