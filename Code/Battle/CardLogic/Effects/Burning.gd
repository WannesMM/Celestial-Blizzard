extends Effect

func effectConstructor():
	effectName = "Burning"
	timeFrames = ["AllyTurn"]
	image = "Burning"
	
func executeEffect(timeFrame: String = ""):
	gameState.damage(applicator,1,target)
	stacks -= 1
	gameState.executeEffects("OnBurning")
	if stacks <= 0:
		removeEffect()
