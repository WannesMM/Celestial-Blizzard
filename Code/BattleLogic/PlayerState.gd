extends Node

class_name PlayerState

var gameState: GameState
var inputHandler: InputHandler

var characterCards: CardLayout = null
var cardHand: CardLayout = null
var areaSupportCards: AreaSupportLayout = null
var entityCards: EntityLayout = null

var activeCharacter: CharacterCardLogic = null
var gold: int = 0
var deck: Deck = null
var turnEnded: bool = false
var roundEnded: bool = false

var drawPile: Array[CardLogic] = []

func _init(newDeck: Deck, input: InputHandler, characterLayout: CardLayout, handLayout: CardLayout, areaSupportLayout: AreaSupportLayout, entityLayout: EntityLayout) -> void:
	deck = newDeck
	inputHandler = input
	
	characterCards = characterLayout
	cardHand = handLayout
	areaSupportCards = areaSupportLayout
	entityCards = entityLayout

# Actual Functionality -----------------------------------------------------------------------------

func setStartingCharacters():
	characterCards.addCards(deck.getCharacterCards())
	
func setStartingHand():
	var arr = deck.getAreaCards() + deck.getEnitityCards() + deck.getEquipmentCards() + deck.getSupporterCards() + deck.getEventCards()
	cardHand.addCards(arr)

# Getters and Setters ------------------------------------------------------------------------------

func getGameState():
	return gameState
	
func setGameState(state: GameState):
	gameState = state
	
func getInputhandler():
	return inputHandler
	
func setInputHandler(handler: InputHandler):
	inputHandler = handler
	
func getCharacterCards():
	return characterCards
	
func setCharacterCards(cards: CardLayout):
	characterCards = cards
	
func getActiveCharacter():
	return activeCharacter
	
func setActiveCharacter(char: CharacterCardLogic):
	activeCharacter = char
	
func getGold():
	return gold
	
func setGold(amt: int):
	gold = amt
	
func getCardHand():
	return cardHand
	
func setCardHand(hand: CardLayout):
	cardHand = hand
	
func getDeck():
	return deck
	
func setDeck(new: Deck):
	deck = new
	
func getTurnEnded():
	return turnEnded
	
func setTurnEnded(turnEnd: bool):
	turnEnded = turnEnd
	
func getRoundEnded():
	return roundEnded

func setRoundEnded(end: bool):
	roundEnded = end
	
