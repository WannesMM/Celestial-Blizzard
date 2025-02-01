extends Node

class_name Deck

var cards: Array[CardLogic]

var characterCards: Array[CharacterCardLogic] = []
var areaCards: Array[AreaCardLogic] = []
var eventCards: Array[EventCardLogic] = []
var supporterCards: Array[SupporterCardLogic] = []
var equipmentCards: Array[EquipmentCardLogic] = []
var entityCards: Array[EntityCardLogic] = []

func _init(newDeck: Array[CardLogic] = []) -> void:
	cards = newDeck
	updateDeck()
	
# Actual Functionality ---------------------------------------------------------

func updateDeck():
	updateCardArrays()

func updateCardArrays():
	characterCards = []
	for card in cards:
		match card.getCardType():
			"CharacterCard":
				characterCards.append(card)
			"EventCard":
				eventCards.append(card)
			"AreaCard":
				areaCards.append(card)
			"EntityCard":
				entityCards.append(card)
			"EquipmentCard":
				equipmentCards.append(card)
			"SupporterCard":
				supporterCards.append(card)
			
# Getter and Setters -----------------------------------------------------------

func getCards():
	return cards
	
func setCards(newCards: Array[CardLogic]):
	cards = newCards
	updateDeck()

func getCharacterCards():
	return characterCards
	
func getEventCards():
	return eventCards
	
func getAreaCards():
	return areaCards

func getSupporterCards():
	return supporterCards
	
func getEnitityCards():
	return entityCards
	
func getEquipmentCards():
	return equipmentCards
