extends Node

class_name Effect

var gameState: GameState

var effectName: String
var timeFrame: String
var applicator: Card
var target: Card

var stacks: int = 0

var image: String

func _init(initializer: Card, targetCard: Card = initializer.cardOwner.opponent.activeCharacter.cardLogic) -> void:
	applicator = initializer
	target = targetCard
	gameState = applicator.gameState
	
	effectConstructor()
	
	target.addEffect(self)
	
func effectConstructor():
	pass

func executeEffect():
	pass

func mergeEffect(effect: Effect):
	stacks += effect.stacks

func removeEffect():
	gameState.scheduledEffects.erase(self)
	target.appliedEffects.erase(self)
	target.card.removeEffect(self)
	queue_free()
