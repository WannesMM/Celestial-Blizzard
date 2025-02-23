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
	
	allyInput = PlayerInput.new(self)
	enemyInput = PlayerInput.new(self)
	
	#print("Ready")
	#print(allyDeck)
	gameState = GameState.new(allyDeck, allyInput, allyCharacterLayout, allyHandLayout, allyAreaSupport, allyEntity,
	enemyDeck, enemyInput, enemyCharacterLayout, enemyHandLayout, enemyAreaSupport, enemyEntity,
	battleResources, self)
	
func initialiseDeck():
	var test = BattleTest.new()
	
	allyDeck = test.burningDeck
	enemyDeck = test.hatsuneMikuDeck
	
	allyDeck.createStack()
	await GlobalSignals.deckLoaded
	print("Deck1 loaded")
	enemyDeck.createStack()
	await GlobalSignals.deckLoaded
	print("Deck2 loaded")
	GlobalSignals.loadComplete.emit()
	
# Code for inputbehaviour --------------------------------------------------------------------------

#0 --> allow no action, 1 --> allow ally action, 2 --> allow enemy action
var allowAction = 0

@export var messageChooseCardScene: PackedScene
var currentMessageChooseCard

@export var messageScene: PackedScene

var currentInput

func selectAction(input):
	if gameState.getActivePlayer().allied:
		allowAction = 1
	else:
		allowAction = 2
	currentInput = input

#Extended modified
func draggedIntoLayout(layout, card: Card):
	if checkActionAllowed(card):
		currentInput.setSelectedAction(["Play Card", card, layout])
	else:
		card.animatePosition(card.getBasePosition())
		message("It is not your turn")

func characterCardMove(type, card):
	if checkActionAllowed(card):
		currentInput.setSelectedAction(["Move", card, type])
	else:
		message("It is not your turn")

func endRound():
	if allowAction != 0:
		currentInput.setSelectedAction(["End Round"])
	else:
		message("It is not your turn")
		
func characterCardSwitch(card):
	if checkActionAllowed(card):
		currentInput.setSelectedAction(["Switch", card])
	else:
		message("It is not your turn")

func checkActionAllowed(card):
	if (allowAction == 1 and card.getLayout().allied == true) || (allowAction == 2 and card.getLayout().allied == false):
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
