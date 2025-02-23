extends Control

class_name LoadingScreen

var nextScene = "res://Scenes/battlefield.tscn"

var progress = []
var progressTween: Tween
var value = 0

func _ready() -> void:
	ResourceLoader.load_threaded_request(nextScene)
	progressTween = get_tree().create_tween()
	
func _process(delta: float) -> void:
	ResourceLoader.load_threaded_get_status(nextScene,progress)
	$ProgressBar.text = str(value) + "%"
	
	if progress[0] == 1:
		progressTween.tween_property(self, "value", 50, 1)
		
		var scene: PackedScene = ResourceLoader.load_threaded_get(nextScene)
		var battleField: BattleManager = scene.instantiate()
		
		print("Waiting for deck loading")
		battleField.initialiseDeck()
		progressTween.tween_property(self, "value", 90, 1)
		await GlobalSignals.loadComplete
		print("Deck loading complete")
		
		progressTween.tween_property(self, "value", 100, 1)
		#await progressTween.finished
		
		#get_tree().change_scene_to_packed(scene)
		
		var current_scene = get_tree().current_scene  # Get current scene
	
		# Add new scene to tree
		get_tree().root.add_child(battleField)
		get_tree().current_scene = battleField
	
		# Remove old scene
		current_scene.queue_free()
	
