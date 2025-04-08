extends CountdownEffect

class_name Effect_Seal

func _init(applicator: Card, target: Card, counter: int) -> void:
	texture = preload("res://assets/Icons/Heal Icon.png")
	super._init(applicator,target,counter)
	events = [Event_CharacterTakesDamage.new(target), Event_EnemyTurn.new(), Event_StartOfRound.new()]
	target.damageReduction += currentBonus

var currentBonus: int = 1: set = setCurrentBonus

func execute(event: Event):
	if event is Event_CharacterTakesDamage:
		if event.character == target:
			applicator.flashCard()
			target.damageReduction -= currentBonus
			currentBonus = 0
	elif event is Event_EnemyTurn:
		if currentBonus == 0:
			applicator.flashCard()
			currentBonus = 1
			target.damageReduction += currentBonus
	elif event is Event_StartOfRound:
		counter -= 1
		if counter < 1:
			remove()

func setCurrentBonus(newBonus: int):
	currentBonus = newBonus
	
