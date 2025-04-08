extends LayoutManager

class_name BattleManager

var gameState: GameState = null

var allyDeck: Deck
var allyInput: InputHandler = null
var enemyDeck: Deck
var enemyInput: InputHandler = null

var allyCharacterLayout: CardLayout = null
var allyHandLayout: CardLayout = null
var enemyCharacterLayout: CardLayout = null
var enemyHandLayout: CardLayout = null
var allyAreaSupport: CardLayout = null
var allyEntity: CardLayout = null
var enemyAreaSupport: CardLayout = null
var enemyEntity: CardLayout = null
var battleResources: BattleRightPanel = null
var eventCardCollision: LayoutCollision = null
var rightSlider = null

@onready var camera = $"../Camera"

# LayoutManager inherited

func startCardDrag(card: Card):
	highlightCollider(card.playableOn())

func layoutManagerConstructor():
	initializeBattle()

func finishCardDrag(card: Card):
	undoHighlightCollider(card.playableOn())

func clickOnCard(card: Card):
	card.getLayout().onClick(card)
	if selectedCards.size() == 1:
		if card.currentLayout is CharacterCardLayout and card == selectedCards[0]:
			characterCardSwitch(card)
	if card.getLayout().getSelectable():
		selectCard(card)

#This selects a card.
func selectCard(card: Card):
	if card in selectedCards:
		undoSelect(card)
		closeCardInformation()
	elif selectedCards.size() >= multiselect:
		undoSelect(selectedCards[0])
		highlightSelect(card)
		displayCardInformation(card)
	else:
		highlightSelect(card)
		displayCardInformation(card)
		selectTarget()
	
func deselectAllCards():
	var i = 0
	var len = selectedCards.size()
	while i < len:
		undoSelect(selectedCards[0])
		i = i + 1
	closeCardInformation()
	assert(selectedCards == [])
	
#This unselects a card
func undoSelect(card):
	if(card.get_tree() != null):
		card.undoHighlightCard()
		card.scaleRelative(Vector2(1,1), ANIMATIONDURATION)
		if card.getLayout().CARD_LAYOUT_TYPE != "CharacterCardLayout":
			card.moveCardDownSelect()
	selectedCards.erase(card)
	if card.currentLayout is CharacterCardLayout:
		card.stopSwitchAnimation()
	
#All the animations for selecting
func highlightSelect(card):
	if card.getLayout().CARD_LAYOUT_TYPE == "CharacterCardLayout":
		card.highlightCard()
		card.scaleRelative(ANIMATIONSCALE, ANIMATIONDURATION)
	else:
		card.highlightCard()
		card.scaleRelative(ANIMATIONSCALE, ANIMATIONDURATION)
		card.moveCardUpSelect(SELECTMOVEMENT)
	selectedCards.append(card)

#For the information slider when selected
func closeCardInformation():
	$"Right Slider".closeCardInformation()

func displayCardInformation(card: Card):
	if card.getLayout().getShowInformation():
		$"Right Slider".displayCardInformation(card)
	if card.currentLayout is CharacterCardLayout and !card.active:
		card.playSwitchAnimation()

# In de param voor deze functie komen uiteindelijk de parameters voor een battle (denk ik)
func initializeBattle():
	allyCharacterLayout = $CharacterCardLayout/AllyLayout
	allyHandLayout = $AllyCardHandLayout/"Card Hand"
	allyAreaSupport = $AreaSupportLayout/AllyLayout
	allyEntity = $EntityLayout/AllyLayout
	enemyCharacterLayout = $CharacterCardLayout/EnemyLayout
	enemyHandLayout = $EnemyCardHandLayout/"Card Hand"
	enemyAreaSupport = $AreaSupportLayout/EnemyLayout
	enemyEntity = $EntityLayout/EnemyLayout
	battleResources = $BattleRightPanel
	eventCardCollision = $Control/EventCardCollision
	rightSlider = $"Right Slider"
	rightSlider.layoutManager = self
	
	#print("Ready")
	#print(allyDeck)
	gameState = GameState.new(allyDeck, allyInput, allyCharacterLayout, allyHandLayout, allyAreaSupport, allyEntity,
	enemyDeck, enemyInput, enemyCharacterLayout, enemyHandLayout, enemyAreaSupport, enemyEntity,
	battleResources, self)
	
#These functions are called in the loading screen to initialise the game
func initialiseGame(allyNewDeck: Deck, allyNewInput: InputHandler, enemyNewDeck: Deck, enemyNewInput: InputHandler):
	allyInput = allyNewInput
	enemyInput = enemyNewInput
	allyDeck = allyNewDeck
	enemyDeck = enemyNewDeck
	await initialiseDeck(allyDeck, enemyDeck)
	
	
func initialiseDeck(allyNewDeck: Deck, enemyNewDeck: Deck):
	
	allyDeck = allyNewDeck
	enemyDeck = enemyNewDeck
	
	allyDeck.createStack()
	print("Deck1 loaded")
	enemyDeck.createStack()
	print("Deck2 loaded")
	
# Code for inputbehaviour --------------------------------------------------------------------------

var currentInput: PlayerInput
var allowAction: Array[int] = []

@export var messageChooseCardScene: PackedScene
var currentMessageChooseCard

@export var messageScene: PackedScene

#Permission 1: Play card
func draggedIntoLayout(layout, card: Card):
	if checkActionAllowed(card) and 1 in allowAction:
		currentInput.setSelectedAction(["Play Card", card, layout])
	else:
		card.animatePosition(card.getBasePosition())
		message("It is not your turn")

#Permission 2: Use move
func characterCardMove(type, card):
	if checkActionAllowed(card) and 2 in allowAction:
		currentInput.setSelectedAction(["Move", card, type])
	else:
		message("It is not your turn")

#Permission 3: End round
func endRound():
	if 3 in allowAction:
		currentInput.setSelectedAction(["End Round"])
	else:
		message("It is not your turn")



#Permission 4: Switch active character
func characterCardSwitch(card: Card):
	if checkActionAllowed(card) and 4 in allowAction:
		if(card.defeated == false):
			currentInput.setSelectedAction(["Switch", card])
		else:
			message("You cannot switch to a defeated character")
	else:
		message("It is not your turn")

var viableTargets: Array[Card] = []

#Permission 5: Select Target(s)
func selectTarget():
	if 5 in allowAction:
		if multiselect == selectedCards.size():
			var allowed = true
			for card in selectedCards:
				if !(card in viableTargets):
					allowed = false
			if allowed:
				currentInput.setSelectedCards()
			else:
				Random.message("Choose a valid target")
				deselectAllCards()
	

func checkActionAllowed(card):
	if currentInput != null:
		if (card.getLayout().allied == currentInput.playerState.allied):
			return true
	return false

func selectCardsMessage(input, cards, amt, message = "Select Card", buttonText = "Confirm"):
	currentMessageChooseCard = messageChooseCardScene.instantiate()
	currentMessageChooseCard.setMessage(message)
	currentMessageChooseCard.setButtonText(buttonText)
	currentMessageChooseCard.setInput(input)
	disableAllInput()
	setMultiselect(amt)
	setDeselectWhenClickEmpty(false)
	
	var layout: CardLayout = currentMessageChooseCard.get_node("SelectLayout")  # Replace with actual name
	layout.modulate.a = 0
	
	add_child(currentMessageChooseCard)
	move_child(currentMessageChooseCard, get_child_count() - 2)
	
	currentMessageChooseCard.addCards(cards)
	
	layout.fadeIn()
	
func removeCurrentMessage():
	var layout = currentMessageChooseCard.get_node("SelectLayout")
	layout.fadeOut()
	
	setMultiselect(1)
	currentMessageChooseCard.removeAllCards()
	remove_child(currentMessageChooseCard)
	deselectAllCards()
	
	enableAllInput()
	
func message(text = "message"):
	var currentMessage
	currentMessage = messageScene.instantiate()
	currentMessage.setMessage(text)
	
	add_child(currentMessage)
	
	await currentMessage.fadeInOut()
	
	remove_child(currentMessage)
	
func displayCard(card: Card, duration: float = 1):
	await $CardDisplay.displayCard(card,duration)
	
func disableAllInput():
	allyCharacterLayout.disableInput()
	allyHandLayout.disableInput()
	allyAreaSupport.disableInput()
	allyEntity.disableInput()
	enemyCharacterLayout.disableInput()
	enemyHandLayout.disableInput()
	enemyAreaSupport.disableInput()
	enemyEntity.disableInput()
	deselectWhenClickEmpty = false
	
func enableAllInput():
	allyCharacterLayout.enableInput()
	allyHandLayout.enableInput()
	allyAreaSupport.enableInput()
	allyEntity.enableInput()
	enemyCharacterLayout.enableInput()
	enemyHandLayout.enableInput()
	enemyAreaSupport.enableInput()
	enemyEntity.enableInput()
	deselectWhenClickEmpty = true

func highlightCollider(collider):
	for coll in collider:
		coll.highlightRect()
		coll.enableCollision()
	
func undoHighlightCollider(collider):
	for coll in collider:
		coll.undoHighlightRect()
		coll.disableCollision()
