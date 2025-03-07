extends SupporterCard

class_name PseudoDragon

func supporterCardConstructor():
	cardName = "Pseudo Dragon"
	imageLink = "PseudoDragon"
	cardCost = 3
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Monster Mayhem"

func getCardDescription() -> String:
	return "Apply 1 burning to the opponent on placement and at the start of each round."
