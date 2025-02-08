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

# Gamefunctionality ------------------------------------------------------------

var stack: Array[CardLogic] = []

func createStack(player: PlayerState):
	stack = cards.duplicate(true)
	for card in stack:
		card.setCardOwner(player)
	
func shuffleStack():
	stack.shuffle()
	
func drawCards(count: int) -> Array:
	var drawn_cards = stack.slice(0, count) 
	stack = stack.slice(count, stack.size()) 
	print(drawn_cards)
	return drawn_cards

func stackAddToBottom(cards: Array[CardLogic]):
	stack.append(cards)

func stackRemoveCard(card: CardLogic):
	stack.erase(card)
	
func stackGetCharacters():
	var toReturn: Array[CharacterCardLogic] = []
	for card in stack:
		if card.getCardType() == "CharacterCard":
			toReturn.append(card)
	return toReturn
	
#Sets which playerState uses this deck this game
	
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
