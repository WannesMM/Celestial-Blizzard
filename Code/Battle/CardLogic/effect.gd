extends Node

class_name Effect

var gameState: GameState

var events: Array[Event] = []
var applicator: Card

var texture = preload("res://assets/Cards/CharacterCard/Hatsune Miku.png")
var iconScene = preload("res://Scenes/Visual/Icon.tscn")

func _init(applicator: Card) -> void:
	self.applicator = applicator
	gameState = applicator.gameState
	gameState.scheduledEffects.append(self)

# Effect -----------------------------------------------------------------------

func execute(event: Event):
	pass

func remove():
	gameState.scheduledEffects.erase(self)
	queue_free()
