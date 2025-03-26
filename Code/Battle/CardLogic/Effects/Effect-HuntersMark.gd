extends Effect

func effectConstructor():
	effectName = "Hunter's Mark"
	timeFrame = "Specific Character Takes Damage"
	additionalInfo = target
	image = "Burning"
	
func executeEffect():
	applicator.flashCard()
	target.receiveDamage(1)
