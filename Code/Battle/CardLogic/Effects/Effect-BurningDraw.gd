extends Effect

func effectConstructor():
	effectName = "BurningDraw"
	timeFrame = "OnBurning"
	image = "Burning"
	
func executeEffect():
	applicator.flashCard()
	applicator.cardOwner.drawCards(1)
