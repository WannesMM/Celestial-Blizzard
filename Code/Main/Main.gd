extends Control

var battleFieldPath: String = "res://Scenes/battlefield.tscn"
@export var loadingScene: PackedScene

func _ready() -> void:
	#var loadingScreen: LoadingScreen = loadingScene.instantiate() 
	#add_child(loadingScreen)
	#
	#await get_tree().process_frame  # Ensure the loading screen renders
	#
	#print("Calling startLoading...")  # Debugging
	#loadingScreen.startLoading(battleFieldPath)  # Now start loading properly
	pass


func loadBattlefield() -> void:
	get_tree().change_scene_to_packed(load("res://Scenes/Main/LoadingScreen.tscn"))
