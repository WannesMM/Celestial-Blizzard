extends Node

class_name Effect

var gameState: GameState

var effectName: String
var timeFrames: Array[String] = []
var applicator: Card
var target: Card

var stacks: int = -1: set = setStacks

var representative: Icon: set = setRepresentative
var image: String

var additionalInfo

func _init(initializer: Card, targetCard: Card = initializer.cardOwner.opponent.activeCharacter, newStacks: int = 0) -> void:
	applicator = initializer
	target = targetCard
	gameState = applicator.gameState
	stacks = newStacks
	effectConstructor()
	
	var merged: bool = false
	for effect: Effect in target.appliedEffects:
		if effect.effectName == effectName:
			mergeEffect(effect)
			merged = true
	
	if merged == false:
		target.addEffect(self)
		gameState.scheduleEffect(self)
	
func effectConstructor():
	pass

func executeEffect(timeFrame: String = ""):
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
