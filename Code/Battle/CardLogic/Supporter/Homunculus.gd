extends SupporterCard

class_name Homunculus

func supporterCardConstructor():
	cardName = "Homunculus"
	imageLink = "Homunculus"
	cardCost = 3
	sampleColor = Color.DARK_GOLDENROD
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Homunculus"

func getCardDescription() -> String:
	return "while Homonculus is on the field, reduce incoming damage by 1 once per turn. At the start of the round, the homunculus will take 1 energy from the active character. If there is no energy, the homunculus will be destroyed and return into the deck."
