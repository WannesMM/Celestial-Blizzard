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

# In de param voor deze functie komen uiteindelijk de parameters voor een battle (denk ik)
func initializeBattle():
	allyCharacterLayout = $CardLayout/AllyLayout
	allyHandLayout = $AllyCardHandLayout/"Card Hand"
	enemyCharacterLayout = $CardLayout/EnemyLayout
	enemyHandLayout = $EnemyCardHandLayout/"Card Hand"
	
	var test = BattleTest.new()
	
	allyDeck = test.deck1
	enemyDeck = test.deck2
	
	gameState = GameState.new(allyDeck, allyInput, allyCharacterLayout, allyHandLayout, enemyDeck, enemyInput, enemyCharacterLayout, enemyHandLayout, self)
	initializeCards()
	
func initializeCards():
	pass
