extends AreaCard

class_name NomaMountains

func areaCardConstructor():
	cardName = "Noma Mountains"
	imageLink = "Noma Gebergte"
	cardCost = 2
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Noma Research"

func getCardDescription() -> String:
	return "At the start of the next 2 rounds, draw an additional 2 cards."
