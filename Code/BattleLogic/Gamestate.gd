extends Node

class_name GameState

var layoutManager: LayoutManager = null

var allyState: PlayerState
var enemyState: PlayerState

var roundCounter: int = 0
var turnCounter: int = 0

func _init(allyDeck: Deck, allyInput: InputHandler, allyCharacterLayout: CardLayout, allyHandLayout: CardLayout, allyAreaSupport: AreaSupportLayout, allyEntity: EntityLayout,
enemyDeck: Deck, enemyInput: InputHandler, enemyCharacterLayout: CardLayout, enemyHandLayout: CardLayout, enemyAreaSupport: AreaSupportLayout, enemyEntity: EntityLayout, battleResources: BattleRightPanel,
layout: LayoutManager) -> void:
	setLayoutManager(layout)
	
	allyState = PlayerState.new(allyDeck, allyInput, allyCharacterLayout, allyHandLayout, allyAreaSupport, allyEntity, battleResources.allyResources)
	enemyState = PlayerState.new(enemyDeck, enemyInput, enemyCharacterLayout, enemyHandLayout, enemyAreaSupport, enemyEntity, battleResources.enemyResources)
	
	startGame()
	
# GameLogic ----------------------------------------------------------------------------------------

var allyTurn: bool = true

func startGame():
	allyState.getDeck().createStack()
	enemyState.getDeck().createStack()
	allyState.shuffleDeck()
	enemyState.shuffleDeck()
	allyState.gainGold(8)
	enemyState.gainGold(8)
	allyState.drawCards(3)
	enemyState.drawCards(3)
	playCard((await allyState.getInputhandler().selectCards(allyState.getDeck().getCharacterCards(), 1))[0])
	allyTurn = false
	playCard((await enemyState.getInputhandler().selectCards(enemyState.getDeck().getCharacterCards(), 1))[0])
	executeRounds()
	
func executeRounds():
	allyState.drawCards(2)
	enemyState.drawCards(2)
	if roundCounter != 0:
		allyState.gainGold(rollGold())
		enemyState.gainGold(rollGold())
	
func playCard(card: CardLogic, layout: CardLayout = null):
	getActivePlayer().playCard(card, layout)
	
func getActivePlayer():
	if allyTurn:
		return allyState
	else:
		return enemyState
	
func rollGold():
	return generateRandom(2, 1, 8, "Normal")
	
func generateRandom(x: int, min_value: int, max_value: int, mode: String = "Normal") -> int:
	if x <= 0:
		push_error("x must be greater than 0")
		return -1  # Error case
	var rolls = []  # Store all generated numbers
	for i in range(x):
		rolls.append(randi_range(min_value, max_value))  # Generate numbers
	match mode:
		"Normal":
			return rolls[randi() % rolls.size()]  # Return a random one
		"Advantage":
			return rolls.max()  # Return the highest roll
		"Disadvantage":
			return rolls.min()  # Return the lowest roll
	return rolls[0]  # Default case (shouldn't happen)
	
# Getter and Setters -------------------------------------------------------------------------------

func getLayoutManager():
	return layoutManager
	
func setLayoutManager(layout: LayoutManager):
	layoutManager = layout
	
func getAllyState():
	return allyState
	
func setAllyState(state: PlayerState):
	allyState = state
	
func getEnemyState():
	return enemyState
	
func setEnemyState(state: PlayerState):
	enemyState = state

func getAllyTurn():
	return allyTurn
	
func setAllyTurn(x: bool):
	allyTurn = x
