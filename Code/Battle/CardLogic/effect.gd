extends Node

class_name Effect

var gameState: GameState

var effectName: String
var timeFrame: String
var applicator: CardLogic
var target: CardLogic

var stacks: int = 0

func _init(initializer: CardLogic, targetCard: CardLogic = initializer.cardOwner.opponent.activeCharacter.cardLogic) -> void:
	applicator = initializer
	target = targetCard
	gameState = applicator.gameState
	effectConstructor()
	
func effectConstructor():
	pass

func executeEffect():
	pass

func mergeEffect(effect: Effect):
	stacks += effect.stacks

func removeEffect():
	gameState.scheduledEffects.erase(self)
	queue_free()
