extends LayoutManager

class_name BattleManager

var gameState: GameState = null

var allyDeck: Deck = null
var allyInput: InputHandler = null
var enemyDeck: Deck = null
var enemyInput: InputHandler = null

# In de param voor deze functie komen uiteindelijk de parameters voor een battle (denk ik)
func initializeBattle():
	var test = BattleTest.new()
	
	allyDeck = test.deck1
	enemyDeck = test.deck2
	
	gameState = GameState.new(allyDeck, allyInput, enemyDeck, enemyInput, self)
	initializeCards()
	
func initializeCards():
	$CardLayout/AllyLayout.addCards(gameState.getAllyState().getCharacterCards())
	$CardLayout/EnemyLayout.addCards(gameState.getEnemyState().getCharacterCards())
	$AllyCardHandLayout/"Card Hand".addCards(gameState.getAllyState().getCharacterCards())
	$EnemyCardHandLayout/"Card Hand".addCards(gameState.getAllyState().getCharacterCards())
