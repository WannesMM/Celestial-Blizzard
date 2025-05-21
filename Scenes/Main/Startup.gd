extends Control

@export var loadingScene: String

func _ready() -> void:
	loadAccount()
	await get_tree().process_frame
	#get_tree().change_scene_to_packed(load("res://Scenes/Main/LoadingScreen.tscn"))
	Load.callLoadingScreen("res://Scenes/Main/MainScreen.tscn")

func loadAccount():
	UserInfo.loadStory()
