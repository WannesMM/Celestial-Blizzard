extends Node

class_name PlayerState

var gameState: GameState
var input: InputHandler

var characterCards: CardLayout = null
var cardHand: CardLayout = null
var areaSupportCards: AreaSupportLayout = null
var entityCards: EntityLayout = null

var activeCharacter: Card = null
var battleResources: BattleResources = null
var deck: Deck = null
var turnEnded: bool = false
var roundEnded: bool = false

var drawPile: Array[CardLogic] = []

func _init(newDeck: Deck, inputhandler: InputHandler, characterLayout: CardLayout, handLayout: CardLayout, areaSupportLayout: AreaSupportLayout, entityLayout: EntityLayout, battleRes: BattleResources, game: GameState) -> void:
	deck = newDeck
	input = inputhandler
	
	characterCards = characterLayout
	cardHand = handLayout
	areaSupportCards = areaSupportLayout
	entityCards = entityLayout
	battleResources = battleRes
	gameState = game

# Actual Functionality -----------------------------------------------------------------------------

func setStartingCharacters():
	characterCards.addCards(deck.getCharacterCards())
	
func setStartingHand():
	var arr = deck.getAreaCards() + deck.getEnitityCards() + deck.getEquipmentCards() + deck.getSupporterCards() + deck.getEventCards()
	cardHand.addCards(arr)

func playCard(card, layout = null):
	var cardType = card.getCardLogic().getCardType()
	match cardType:
		"CharacterCard":
			getCharacterCards().addCard(card)
		"EventCard":
			pass
		"AreaCard":
			getAreaSupportCards().addCard(card)
		"SupporterCard":
			if layout is Card:
				if layout.getCardLogic().getCardType() == "AreaCard":
					print("Zou supporter moeten toegevoegd hebben")
					layout.addRelatedCard(card)
				
		"EntityCard":
			getEntityCards().addCard(card)
		"EquipmentCard":
			pass
	card.getCardLogic().playCard()
	
func drawCards(amt: int):
	cardHand.addCards(deck.drawCards(amt))
	
func shuffleDeck():
	deck.shuffleStack()
	
func chooseStartingCharacter():
	input.chooseStartingCharacter()
	
func gainGold(amt: int):
	battleResources.gainGold(amt)
	
func getCharacterCardsLogic():
	return input.convertToCardLogic(characterCards.getAddedCards())
	
func setActiveCharacter(card: Card = null):
	if card != null:
		if card in getCharacterCards().addedCards:
			activeCharacter = card
			activeCharacter.cardLogic.setActive(true)
	
# Getters and Setters ------------------------------------------------------------------------------

func getGameState():
	return gameState
	
func setGameState(state: GameState):
	gameState = state
	
func getInputhandler():
	return input
	
func setInputHandler(handler: InputHandler):
	input = handler
	
func getCharacterCards():
	return characterCards
	
func getAreaSupportCards():
	return areaSupportCards
	
func getEntityCards():
	return entityCards
	
func setCharacterCards(cards: CardLayout):
	characterCards = cards
	
func setAreaSupportCards(cards: CardLayout):
	areaSupportCards = cards
	
func setEntityCards(cards: CardLayout):
	entityCards = cards
	
func getActiveCharacter():
	return activeCharacter
	
func getBattleResources():
	return battleResources
	
func setBattleResources(res: BattleResources):
	battleResources = res
	
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
	
