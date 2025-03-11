extends Node

@export var cardScene = "res://Scenes/Main/Card.tscn"

func loadCard(cardScript: Script):
	var card = load(cardScene).instantiate()
	card.set_script(cardScript)
	card.cardConstructor()
	return card

func loadCards(cardNames: Array[String]):
	var cards: Array[Card] = []
	
	for cardName in cardNames:
		cards.append(loadCard(loadScript(cardName)))
		
	return cards
		
func loadScript(cardName: String):
	loadCardData(cardName)
	var mewScript: String = cardData.get("Script")
	var script: Script = load(mewScript) as Script
	return script

#Read card Data

@export var filePath: String = "res://File/Cards.json"

var cardData = {}

func loadCardData(card: String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath,FileAccess.READ)
		var parsedResult: Dictionary = JSON.parse_string(dataFile.get_as_text())
		if parsedResult is Dictionary:
			cardData = parsedResult.get(card)
		else:
			Random.message("Could not find cardData")
	else:
		Random.message("Failed to load cardData file")
