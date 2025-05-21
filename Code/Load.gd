extends Node

#LoadingScreen------------------------------------------------------------------

var loadingScene = "res://Scenes/Main/LoadingScreen.tscn"
var fadeRect: ColorRect

func _ready() -> void:
	fadeRect = ColorRect.new()
	fadeRect.set_anchors_preset(Control.PRESET_FULL_RECT)
	fadeRect.z_index = 100
	fadeRect.modulate.a = 0
	setOverlayColor(Color.BLACK)
	add_child(fadeRect)

func fadeOverlay(value: float, duration: float = 1):
	await create_tween().tween_property(fadeRect,"modulate:a", value, duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO).finished

func setOverlayColor(color: Color):
	fadeRect.color = color

func callLoadingScreen(toLoad: String, mode: int = 1):
	await fadeOverlay(1)
	
	var scene: PackedScene = load(loadingScene)
	var instance = scene.instantiate()
	
	var current_scene = get_tree().current_scene  # Get current scene
	
	get_tree().root.add_child(instance)
	get_tree().current_scene = instance
	instance.startLoad(toLoad, mode)
	# Remove old scene
	current_scene.queue_free()

#DataLoader---------------------------------------------------------------------

var data = {}

func loadData(subject: String, filePath: String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath,FileAccess.READ)
		var parsedResult: Dictionary = JSON.parse_string(dataFile.get_as_text())
		if parsedResult is Dictionary:
			data = parsedResult.get(subject)
		else:
			Random.message("Could not find requested data")
	else:
		Random.message("Failed to load specified data file")

#Load Card ---------------------------------------------------------------------

var cardScene: PackedScene = preload("res://Scenes/Main/Card.tscn")

func loadCard(cardName: String) -> Card:
	var cardScript: Script = loadScript(cardName)
	var card = cardScene.instantiate()
	card.set_script(cardScript)
	card.cardConstructor()
	return card

func loadCards(cardNames) -> Array[Card]:
	var cards: Array[Card] = []
	
	for cardName in cardNames:
		cards.append(loadCard(cardName))
	return cards
		
func loadScript(cardName: String):
	loadData(cardName, cardsPath)
	var mewScript: String = data.get("Script")
	var script: Script = load(mewScript) as Script
	return script

#Read card Data

@export var cardsPath: String = "res://File/Cards.json"

# Load Animation ---------------------------------------------------------------

@export var animationPath: String = "res://File/Animations.json"

func loadAnimation(animation: String) -> Animate:
	loadData(animation, animationPath)
	var scene: PackedScene = load(data.get("Scene"))
	return scene.instantiate()

func playAnimation(animation: Animate):
	get_tree().current_scene.add_child(animation)
	await animation.play()

func removeAnimation(animation: Animate):
	get_tree().current_scene.remove_child(animation)
	animation.queue_free()

# Messages ---------------------------------------------------------------------

var announcementScene = preload("res://Scenes/Main/Announcement.tscn")

func announce(text = "message"):
	var announcement = announcementScene.instantiate()
	announcement.setText(text)
	
	get_tree().current_scene.add_child(announcement)
	
	await announcement.play()
	
	get_tree().current_scene.remove_child(announcement)
	
var introduceScene = preload("res://Scenes/Main/Introduce.tscn")

func introduce(text = "message"):
	var announcement = introduceScene.instantiate()
	announcement.setText(text)
	
	get_tree().current_scene.add_child(announcement)
	
	await announcement.play()
	
	get_tree().current_scene.remove_child(announcement)
