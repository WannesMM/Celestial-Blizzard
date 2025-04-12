extends CountdownEffect

class_name Effect_HuntersMark

func _init(applicator: Card, target: Card, counter: int) -> void:
	texture = preload("res://assets/Icons/Hunter's Mark Icon.png")
	info = "Receive 1 additional damage once per turn"
	super._init(applicator,target,counter)
	events = [Event_CharacterTakesDamage.new(target), Event_EnemyTurn.new()]
	target.damageReduction -= currentBonus

var currentBonus: int = 1: set = setCurrentBonus

func execute(event: Event):
	if event is Event_CharacterTakesDamage:
		if event.character == target:
			applicator.flashCard()
			target.damageReduction += currentBonus
			currentBonus = 0
	elif event is Event_EnemyTurn:
		if currentBonus == 0:
			applicator.flashCard()
			currentBonus = 1
			target.damageReduction -= currentBonus

func setCurrentBonus(newBonus: int):
	currentBonus = newBonus
	counter = currentBonus
	
