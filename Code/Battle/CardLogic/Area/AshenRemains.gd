extends AreaCard

func areaCardConstructor():
	cardName = "Ashen Remains"
	imageScale = Vector2(4,4)
	imageLink = "Ashen Remains"
	sampleColor = Color.DIM_GRAY
	
	cardCost = 0
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Lost in the flames"

func getCardDescription() -> String:
	return "This space cannot be occupied by supporters"
