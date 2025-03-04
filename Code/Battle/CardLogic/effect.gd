extends Node

class_name Effect

var gameState: GameState

var effectName: String
var timeFrame: String
var applicator: CardLogic
var target: CardLogic

var stacks: int = 0

var icon: String = "res://assets/Cards/CharacterCard/Hatsune Miku.png"

func _init(initializer: CardLogic, targetCard: CardLogic = initializer.cardOwner.opponent.activeCharacter.cardLogic) -> void:
	applicator = initializer
	target = targetCard
	target.addEffect(self)
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
	target.appliedEffects.erase(self)
	queue_free()
