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
var battleResources: BattleRightPanel = null
var eventCardCollision: LayoutCollision = null

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
	
	var test = BattleTest.new()
	
	allyDeck = test.burningDeck
	enemyDeck = test.hatsuneMikuDeck
	allyInput = PlayerInput.new(self)
	enemyInput = PlayerInput.new(self)
	
	gameState = GameState.new(allyDeck, allyInput, allyCharacterLayout, allyHandLayout, allyAreaSupport, allyEntity,
	enemyDeck, enemyInput, enemyCharacterLayout, enemyHandLayout, enemyAreaSupport, enemyEntity,
	battleResources, self)
	
# Code for inputbehaviour --------------------------------------------------------------------------

@export var messageChooseCardScene: PackedScene
var currentMessage

#Extended modified
func draggedIntoLayout(layout, card):
	gameState.playCard(card.getCardLogic(),layout)

func selectCardsMessage(input, cards, amt, message = "Select Card", buttonText = "Confirm"):
	currentMessage = messageChooseCardScene.instantiate()
	currentMessage.setMessage(message)
	currentMessage.setButtonText(buttonText)
	currentMessage.setInput(input)
	disableAllInput()
	setMultiselect(amt)
	setDeselectWhenClickEmpty(false)
	
	var layout = currentMessage.get_node("SelectLayout")  # Replace with actual name
	layout.modulate.a = 0
	
	add_child(currentMessage)
	move_child(currentMessage, get_child_count() - 2)
	
	currentMessage.addCards(cards)
	
	layout.fadeIn()
	
func removeCurrentMessage():
	var layout = currentMessage.get_node("SelectLayout")
	layout.fadeOut()
	
	setMultiselect(1)
	currentMessage.removeAllCards()
	remove_child(currentMessage)
	deselectAllCards()
	
	enableAllInput()
	
func disableAllInput():
	allyCharacterLayout.disableInput()
	allyHandLayout.disableInput()
	allyAreaSupport.disableInput()
	allyEntity.disableInput()
	enemyCharacterLayout.disableInput()
	enemyHandLayout.disableInput()
	enemyAreaSupport.disableInput()
	enemyEntity.disableInput()
	
func enableAllInput():
	allyCharacterLayout.enableInput()
	allyHandLayout.enableInput()
	allyAreaSupport.enableInput()
	allyEntity.enableInput()
	enemyCharacterLayout.enableInput()
	enemyHandLayout.enableInput()
	enemyAreaSupport.enableInput()
	enemyEntity.enableInput()

func highlightCollider(collider):
	for coll in collider:
				coll.highlightRect()
	
func undoHighlightCollider(collider):
	for coll in collider:
				coll.undoHighlightRect()
