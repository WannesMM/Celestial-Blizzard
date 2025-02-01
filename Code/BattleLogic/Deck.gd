extends Node

class_name Deck

var cards: Array[CardLogic]

var characterCards: Array[CharacterCardLogic] = []
var areaCards: Array[AreaCardLogic] = []

func _init(newDeck: Array[CardLogic] = []) -> void:
	cards = newDeck
	updateDeck()
	
# Actual Functionality ---------------------------------------------------------

func updateDeck():
	updateCharacterCards()
	updateAreaCards()

func updateCharacterCards():
	characterCards = []
	for card in cards:
		if card.getCardType() == "CharacterCard":
			characterCards.append(card)
			
func updateAreaCards():
	areaCards = []
	for card in cards:
		if card.getCardType() == "AreaCard":
			areaCards.append(card)

			
# Getter and Setters -----------------------------------------------------------

func getCards():
	return cards
	
func setCards(newCards: Array[CardLogic]):
	cards = newCards
	updateDeck()

func getCharacterCards():
	return characterCards
	
func getAreaCards():
	return areaCards
