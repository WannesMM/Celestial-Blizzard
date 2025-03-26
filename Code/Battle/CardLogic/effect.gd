extends Node

class_name Effect

var gameState: GameState

var effectName: String
var timeFrame: String
var applicator: Card
var target: Card

var stacks: int = -1: set = setStacks

var representative: Icon: set = setRepresentative
var image: String

var additionalInfo

func _init(initializer: Card, targetCard: Card = initializer.cardOwner.opponent.activeCharacter) -> void:
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

func setRepresentative(repr: Icon):
	representative = repr

func setStacks(newStacks: int):
	stacks = newStacks
	representative.setUses(str(stacks))
