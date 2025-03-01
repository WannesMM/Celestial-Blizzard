extends Control

@export var loadingScene: String

func _ready() -> void:
	await get_tree().process_frame
	AudioEngine.playAmbience("Wind")
	#get_tree().change_scene_to_packed(load("res://Scenes/Main/LoadingScreen.tscn"))
	Random.callLoadingScreen("Story")
