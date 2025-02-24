extends Control

@export var loadingScene: String

func _ready() -> void:
	#get_tree().change_scene_to_packed(load("res://Scenes/Main/LoadingScreen.tscn"))
	var scene: PackedScene = load(loadingScene)
	var instance = scene.instantiate()
	
	var current_scene = get_tree().current_scene  # Get current scene
	get_tree().root.add_child.call_deferred(instance)
	get_tree().current_scene = instance
	instance.startLoad("Title")
	# Remove old scene
	
