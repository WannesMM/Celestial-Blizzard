extends Control

var battleFieldPath: String = "res://Scenes/battlefield.tscn"
@export var loadingScene: PackedScene

func _ready() -> void:
	AudioEngine.playTitleScreenMusic(Random.generateRandom(1,1,4))
	AudioEngine.playAmbience("Wind")
	
	#var loadingScreen: LoadingScreen = loadingScene.instantiate() 
	#add_child(loadingScreen)
	#
	#await get_tree().process_frame  # Ensure the loading screen renders
	#
	#print("Calling startLoading...")  # Debugging
	#loadingScreen.startLoading(battleFieldPath)  # Now start loading properly
	
func loadBattlefield() -> void:
	get_tree().change_scene_to_packed(load("res://Scenes/Main/LoadingScreen.tscn"))
