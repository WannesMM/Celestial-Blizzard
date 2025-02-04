extends LayoutManager

class_name BattleManager

var gameState: GameState = null

var allyDeck: Deck = null
var allyInput: InputHandler = null
var enemyDeck: Deck = null
var enemyInput: InputHandler = null

var allyCharacterLayout: CardLayout = null
var allyHandLayout: CardLayout = null
var enemyCharacterLayout: CardLayout = null
var enemyHandLayout: CardLayout = null
var allyAreaSupport: CardLayout = null
var allyEntity: CardLayout = null
var enemyAreaSupport: CardLayout = null
var enemyEntity: CardLayout = null

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
	
	var test = BattleTest.new()
	
	allyDeck = test.burningDeck
	enemyDeck = test.burningDeck2
	allyInput = PlayerInput.new(self)
	enemyInput = PlayerInput.new(self)
	
	gameState = GameState.new(allyDeck, allyInput, allyCharacterLayout, allyHandLayout, allyAreaSupport, allyEntity,
	enemyDeck, enemyInput, enemyCharacterLayout, enemyHandLayout, enemyAreaSupport, enemyEntity,
	self)
	
# Code for inputbehaviour --------------------------------------------------------------------------

@export var messageChooseCardScene: PackedScene
var currentMessage

#Extended modified
func draggedIntoLayout(layout, card):
	gameState.playCard(card,layout)

func selectCardsMessage(input, cards, amt, message = "Select Card", buttonText = "Confirm"):
	currentMessage = messageChooseCardScene.instantiate()
	currentMessage.addCards(cards)
	currentMessage.setMessage(message)
	currentMessage.setButtonText(buttonText)
	currentMessage.setInput(input)
	setMultiselect(amt)
	setDeselectWhenClickEmpty(false)
	add_child(currentMessage)
	
func removeCurrentMessage():
	deselectAllCards()
	setMultiselect(1)
	remove_child(currentMessage)
	
