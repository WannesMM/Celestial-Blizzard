extends Effect

class_name Burning

func effectConstructor():
	effectName = "Burning"
	timeFrame = "AllyTurn"
	icon = "res://assets/Icons/Effect/BurningIcon.jpeg"
	
func executeEffect():
	gameState.damage(applicator,1,target)
	stacks -= 1
	if stacks <= 0:
		removeEffect()
