extends AreaCard

func areaCardConstructor():
	cardName = "Ashen Remains"
	imageLink = "Ashen Remains"
	sampleColor = Color.DIM_GRAY
	
	amountSupporter = 0
	cardCost = 0
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Lost in the flames"

func getCardDescription() -> String:
	return "This space cannot be occupied by supporters"
