extends Effect

func effectConstructor():
	effectName = "Burning"
	timeFrame = "AllyTurn"
	image = "Burning"
	
func executeEffect():
	gameState.damage(applicator,1,target)
	stacks -= 1
	gameState.executeEffects("OnBurning")
	if stacks <= 0:
		removeEffect()
