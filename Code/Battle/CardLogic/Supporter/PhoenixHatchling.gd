extends SupporterCard

class_name PhoenixHatchling

func supporterCardConstructor():
	cardName = "Phoenix Hatchling"
	imageLink = "Phoenix"
	cardCost = 3
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Monster Mayhem"

func getCardDescription() -> String:
	return "Upon placing it on an area, destroy this and the phoenix hatchling. Deal 3 + the cost of the removed building damage on the opponent."
