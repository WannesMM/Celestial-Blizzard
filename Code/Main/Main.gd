extends Control

var battleFieldPath: String = "res://Scenes/battlefield.tscn"
@export var loadingScene: String

func _ready() -> void:
	modulate.v = 0
	$Control/TitleLight.energy = 0
	AudioEngine.playTitleScreenMusic(Random.generateRandom(1,1,4))
	AudioEngine.playAmbience("Wind",3,4)
	Random.wait(1)
	var fadeTween = create_tween()
	fadeTween.tween_property(self, "modulate:v", 1, 1)
	await fadeTween.finished
	
	$Control/TitleLight.energy = 0
	#var loadingScreen: LoadingScreen = loadingScene.instantiate() 
	#add_child(loadingScreen)
	#
	#await get_tree().process_frame  # Ensure the loading screen renders
	#
	#print("Calling startLoading...")  # Debugging
	#loadingScreen.startLoading(battleFieldPath)  # Now start loading properly
	
func loadBattlefield() -> void:
	var fadeTween = create_tween()
	fadeTween.tween_property(self, "modulate:v", 0, 1)
	await fadeTween.finished
	
	var scene: PackedScene = load(loadingScene)
	var instance = scene.instantiate()
	
	var current_scene = get_tree().current_scene  # Get current scene
	get_tree().root.add_child(instance)
	get_tree().current_scene = instance
	instance.startLoad("BattleField")
	# Remove old scene
	current_scene.queue_free()

var battleScaleTween: Tween

func BattleMouseEntered() -> void:
	battleScaleTween = create_tween()
	battleScaleTween.tween_property($Control/TitleLight,"energy",10,1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)

func BattleMouseExited() -> void:
	battleScaleTween = create_tween()
	battleScaleTween.tween_property($Control/TitleLight,"energy",0,1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)

func loadDuringLoadingScreen():
	Random.wait(1)
	GlobalSignals.loadComplete.emit()
