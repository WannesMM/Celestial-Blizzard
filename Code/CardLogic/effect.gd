extends Node

class_name Effect

var effectName: String
var timeFrame: String

func _init(initializer: CardLogic, target: Card = null) -> void:
	target = initializer.owner.opponent.getActiveCharacter()
	effectConstructor()
	
func effectConstructor():
	pass

func executeEffect():
	pass
