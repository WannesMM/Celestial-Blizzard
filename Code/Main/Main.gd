extends Control

var battleFieldPath: String = "res://Scenes/battlefield.tscn"
@export var loadingScene: PackedScene

func _ready() -> void:
	modulate.v = 0
	$PointLight2D4.energy = 0
	AudioEngine.playTitleScreenMusic(Random.generateRandom(1,1,4))
	AudioEngine.playAmbience("Wind",3,4)
	Random.wait(1)
	var fadeTween = create_tween()
	fadeTween.tween_property(self, "modulate:v", 1, 1)
	await fadeTween.finished
	
	$PointLight2D4.energy = 0
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
	get_tree().change_scene_to_packed(load("res://Scenes/Main/LoadingScreen.tscn"))

var battleScaleTween: Tween

func BattleMouseEntered() -> void:
	battleScaleTween = create_tween()
	battleScaleTween.tween_property($PointLight2D4,"energy",10,1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)

func BattleMouseExited() -> void:
	battleScaleTween = create_tween()
	battleScaleTween.tween_property($PointLight2D4,"energy",0,1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)

func loadDuringLoadingScreen():
	Random.wait(1)
	GlobalSignals.loadComplete.emit()
