extends Control

class_name LoadingScreen

var nextScene = "res://Scenes/Battle/battlefield.tscn"

var progressBar: LoadingBar

var progress = []
var progressTween: Tween
var value = 0

func _ready() -> void:
	startLoad()
	
func _process(delta: float) -> void:
	ResourceLoader.load_threaded_get_status(nextScene,progress)
	
	if progress[0] == 1:
		GlobalSignals.loadingBlock.emit()
	
func startLoad():
	progressBar = $ProgressBar
	progressBar.resetProgress()
	ResourceLoader.load_threaded_request(nextScene)
	
	progressBar.tweenProgress(50)
	
	await GlobalSignals.loadingBlock
	
	progressBar.tweenProgress(90)
	
	var scene: PackedScene = ResourceLoader.load_threaded_get(nextScene)
	var battleField: BattleManager = scene.instantiate()
	
	print("Waiting for deck loading")
	battleField.initialiseDeck()
	
	progressBar.tweenProgress(100)
	
	await GlobalSignals.loadComplete
	
	print("Deck loading complete")
	
	var current_scene = get_tree().current_scene  # Get current scene

	# Add new scene to tree
	get_tree().root.add_child(battleField)
	get_tree().current_scene = battleField
	
	# Remove old scene
	current_scene.queue_free()
