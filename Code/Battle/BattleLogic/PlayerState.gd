extends Node

class_name PlayerState

var gameState: GameState
var input: InputHandler: set = setInputHandler

var characterCards: CardLayout = null
var cardHand: CardHandLayout = null
var areaSupportCards: AreaSupportLayout = null
var entityCards: EntityLayout = null

var activeCharacter: Card = null
var battleResources: BattleResources = null
var deck: Deck = null
var turnEnded: bool = false
var roundEnded: bool = false

var drawPile: Array[Card] = []

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
			if checkCost(action[1].cardCost):
				reduceGold(action[1].cardCost)
				playCard(action[1], action[2])
			else:
				action[1].animatePosition(action[1].basePosition)
		"Move":
			if action[1].isPossibleMove(action[0]) and checkCost(action[1].getMoveCost(action[2])):
				match action[2]:
					"NA":
						await action[1].onMove(action[2])
						await action[1].NA()
						setTurnEnded(true)
					"SA":
						await action[1].onMove(action[2])
						await action[1].SA()
						setTurnEnded(true)
					"CA":
						if action[1].checkEnergy():
							await action[1].onMove(action[2])
							await action[1].CA()
							setTurnEnded(true)
						else:
							Random.message("You don't have enough spirit")
				await gameState.executeEffects(Event_CharacterUsesMove.new(action[1],action[2]))
		"End Round": 
			setTurnEnded(true)
			setRoundEnded(true)
			gameState.lastTurnEnder = self
		"Switch":
			if(!action[1].active):
				setActiveCharacter(action[1])
				setTurnEnded(true)
	

func playCard(card: Card, layout = null):
	var cardType = card.getCardType()
	await gameState.layoutManager.displayCard(card)
	
	match cardType:
		"CharacterCard":
			getCharacterCards().addCard(card)
		"EventCard":
			deck.stackAddToBottom(card)
		"AreaCard":
			getAreaSupportCards().addCard(card)
		"SupporterCard":
			playSupporter(card, layout)
		"EntityCard":
			getEntityCards().addCard(card)
		"EquipmentCard":
			pass
	card.playCard(layout)
	await gameState.executeEffects(Event_PlayCard.new(card))
	await gameState.executeEffects(Event_PlayCardType.new(card.getCardType()))

func playSupporter(card: Card, layout):
	if layout is Card:
		if layout.getCardType() == "AreaCard":
			layout.addRelatedCard(card)
	
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
	
func reduceGold(amt: int):
	battleResources.reduceGold(amt)
	
func setActiveCharacter(card: Card = null):
	if card != null:
		if card in getCharacterCards().addedCards and card != activeCharacter:
			if activeCharacter != null:
				activeCharacter.setActive(false)
			activeCharacter = card
			activeCharacter.setActive(true)
	
func damage(attacker: Card, dmg: int, defender: Card = opponent.getActiveCharacter()):
	await gameState.damage(attacker, dmg, defender)
	
func checkCost(cost: int):
	if cost > battleResources.gold:
		Random.message("You don't have enough gold")
		return false
	else:
		return true
	
func chooseActiveCharacter():
	var switch = await input.chooseActiveCharacter()
	setActiveCharacter(switch[1])

func createCard(cardName: String):
	var card: Card = Load.loadCard(cardName)
	card.setCardOwner(self)
	return card
	
# Getters and Setters ------------------------------------------------------------------------------

func getGameState():
	return gameState
	
func setGameState(state: GameState):
	gameState = state
	
func getInputhandler() -> InputHandler:
	return input
	
func setInputHandler(handler: InputHandler):
	input = handler
	handler.playerState = self
	
func getCharacterCards():
	return characterCards
	
func getAreaSupportCards() -> CardLayout:
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
	
