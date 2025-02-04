extends Node

class_name GameState

var layoutManager: LayoutManager = null

var allyState: PlayerState
var enemyState: PlayerState

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
	allyState.getCharacterCards().addCards(await allyState.getInputhandler().selectCards(allyState.getDeck().getCharacterCards(), 2))
	enemyState.getCharacterCards().addCards(await allyState.getInputhandler().selectCards(allyState.getDeck().getCharacterCards(), 2))
	
func playCard(card: Card, layout: CardLayout = null):
	getActivePlayer().playCard(card, layout)
	
func getActivePlayer():
	if allyTurn:
		return allyState
	else:
		return enemyState
	
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
