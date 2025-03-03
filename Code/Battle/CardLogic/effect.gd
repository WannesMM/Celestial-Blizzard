extends Node

class_name Effect

var gameState: GameState

var effectName: String
var timeFrame: String
var applicator: CardLogic
var targets: Array[CardLogic] = []

var stacks: int = 0

func _init(initializer: CardLogic) -> void:
	applicator = initializer
	gameState = applicator.gameState
	effectConstructor()
	
func effectConstructor():
	pass

func executeEffect():
	pass
