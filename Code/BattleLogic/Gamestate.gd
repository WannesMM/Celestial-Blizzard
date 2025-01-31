extends Node

class_name GameState

var layoutManager: LayoutManager = null

var allyState: PlayerState
var enemyState: PlayerState

func _init(allyDeck: Deck, allyInput: InputHandler, enemyDeck: Deck, enemyInput: InputHandler, layout: LayoutManager) -> void:
	setLayoutManager(layout)
	
	allyState = PlayerState.new(allyDeck, allyInput)
	
	enemyState = PlayerState.new(enemyDeck, enemyInput)
	
# Getter and Setters -----------------------------------------------------------

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
