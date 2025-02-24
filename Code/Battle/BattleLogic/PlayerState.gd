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

var allied: bool
var opponent: PlayerState

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

func chooseAction():
	var action = await getInputhandler().chooseAction()
	match action[0]:
		"Play Card":
			playCard(action[1], action[2])
		"Move":
			assert(action[1].cardLogic is CharacterCardLogic)
			if action[1].cardLogic.isPossibleMove(action[0]):
				match action[2]:
					"NA":
						action[1].cardLogic.NA()
					"SA":
						action[1].cardLogic.SA()
					"CA":
						action[1].cardLogic.CA()
				setTurnEnded(true)
		"End Round": 
			setTurnEnded(true)
			setRoundEnded(true)
		"Switch":
			assert(action[1].cardLogic is CharacterCardLogic)
			if(!action[1].cardLogic.active):
				setActiveCharacter(action[1])
				setTurnEnded(true)
			

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
	
func setGold(amt: int):
	battleResources.setGold(amt)
	
func gainGold(amt: int):
	battleResources.gainGold(amt)
	
func getCharacterCardsLogic():
	return input.convertToCardLogic(characterCards.getAddedCards())
	
func setActiveCharacter(card: Card = null):
	if card != null:
		if card in getCharacterCards().addedCards and card != activeCharacter:
			if activeCharacter != null:
				activeCharacter.cardLogic.setActive(false)
			activeCharacter = card
			assert(activeCharacter == activeCharacter.cardLogic.card)
			activeCharacter.cardLogic.setActive(true)
	
func damage(attacker: CardLogic, dmg: int, defender: Card = opponent.getActiveCharacter()):
	gameState.damage(attacker, dmg, defender)
	
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
	
