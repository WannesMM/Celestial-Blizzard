extends Effect

func effectConstructor():
	effectName = "Hunter's Mark"
	events = [Event_CharacterTakesDamage.new(target), Event_EnemyTurn.new()]
	additionalInfo = target
	image = "Hunter's Mark"
	
	target.damageReduction -= currentBonus

var currentBonus: int = 1: set = setCurrentBonus

func executeEffect(timeFrame: String = ""):
	if timeFrame == "Specific Character Takes Damage":
		applicator.flashCard()
		target.damageReduction += currentBonus
		currentBonus = 0
	elif timeFrame == "EnemyTurn":
		if currentBonus == 0:
			applicator.flashCard()
			currentBonus = 1
			target.damageReduction -= currentBonus

func setCurrentBonus(newBonus: int):
	currentBonus = newBonus
	stacks = currentBonus
	
