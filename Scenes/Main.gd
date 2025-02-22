extends Control

@export var battleFieldScene: PackedScene
@export var loadingScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var loadingScreen: LoadingScreen = loadingScene.instantiate() 
	add_child(loadingScreen)
	loadingScreen.startLoading(battleFieldScene)
