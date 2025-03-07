extends AreaCard

class_name NieuwToren

func areaCardConstructor():
	cardName = "Nieuwtoren"
	imageLink = "Nieuwtoren"
	cardCost = 3
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Lost by justice"

func getCardDescription() -> String:
	return "Destroy every supporter and region card on the arena, both yours and your opponent's and replace them with an ash card"
