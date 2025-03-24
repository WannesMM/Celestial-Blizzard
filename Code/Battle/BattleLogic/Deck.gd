extends Node

class_name Deck

var cards: Array[String]

var characterCards: Array[String] = []
var areaCards: Array[String] = []
var eventCards: Array[String] = []
var supporterCards: Array[String] = []
var equipmentCards: Array[String] = []
var entityCards: Array[String] = []

func _init(newDeck: Array[String] = []) -> void:
	cards = newDeck
	updateDeck()
	
# Actual Functionality ---------------------------------------------------------

func updateDeck():
	pass

# Gamefunctionality ------------------------------------------------------------

var stack: Array[Card] = []

func createStack() -> void:
	stack = Load.loadCards(cards)

func assignOwner(player: PlayerState):
	for card in stack:
		card.setCardOwner(player)
		card.gameState = player.gameState

func shuffleStack():
	stack.shuffle()
	
func drawCards(count: int) -> Array:
	var drawn_cards = stack.slice(0, count) 
	stack = stack.slice(count, stack.size()) 
	return drawn_cards

func stackAddToBottom(card: Card):
	stack.append(card)

func stackRemoveCard(card: Card):
	stack.erase(card)
	
func stackGetCharacters():
	var toReturn: Array[CharacterCard] = []
	for card in stack:
		if card is CharacterCard:
			toReturn.append(card)
	return toReturn

#Sets which playerState uses this deck this game
	
# Getter and Setters -----------------------------------------------------------

func getCards():
	return cards
	
func setCards(newCards: Array[String]):
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
