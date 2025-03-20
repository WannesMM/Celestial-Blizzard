extends Node

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

func loadCards(cardNames: Array[String]) -> Array[Card]:
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

func loadAnimation(animation: String):
	loadData(animation, animationPath)
	var scene: PackedScene = load(data.get("Scene"))
	return scene.instantiate()

# Load Effect ------------------------------------------------------------------

@export var effectsPath: String = "res://File/Effects.json"

func loadEffect(effect: String, initialiser: Card, target: Card = initialiser.cardOwner.opponent.activeCharacter) -> Effect:
	loadData(effect, effectsPath)
	var script: Script = load(data.get("Code"))
	return script.new(initialiser, target)

# Messages ---------------------------------------------------------------------

var announcementScene = preload("res://Scenes/Main/Announcement.tscn")

func announce(text = "message"):
	var announcement = announcementScene.instantiate()
	announcement.setText(text)
	
	get_tree().current_scene.add_child(announcement)
	
	await announcement.play()
	
	get_tree().current_scene.remove_child(announcement)
	
var introduceScene = "res://Scenes/Main/Introduce.tscn"

func introduce(text = "message"):
	var announcement = load(introduceScene).instantiate()
	announcement.setText(text)
	
	get_tree().current_scene.add_child(announcement)
	
	await announcement.play()
	
	get_tree().current_scene.remove_child(announcement)
