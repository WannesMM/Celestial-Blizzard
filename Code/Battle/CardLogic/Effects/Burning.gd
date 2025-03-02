extends Effect

class_name Burning

func effectConstructor():
	effectName = "Burning"
	timeFrame = "AllyTurn"
	
func executeEffect():
	gameState.damage(applicator,1,target)
	stacks -= 1
	if stacks <= 0:
		removeEffect()
