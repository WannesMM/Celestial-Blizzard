extends Effect

class_name BerlaarEffect

func effectConstructor():
	effectName = "Berlaar"
	timeFrame = "OnBurning"
	image = "Burning"
	
func executeEffect():
	applicator.cardOwner.drawCards(1)
