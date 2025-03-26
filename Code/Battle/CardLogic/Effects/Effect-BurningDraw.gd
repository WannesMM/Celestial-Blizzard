extends Effect

func effectConstructor():
	effectName = "BurningDraw"
	timeFrames = ["OnBurning"]
	image = "Burning"
	
func executeEffect(timeFrame: String = ""):
	applicator.flashCard()
	applicator.cardOwner.drawCards(1)
