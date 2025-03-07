extends SupporterCard

class_name Hermit

func supporterCardConstructor():
	cardName = "Hermit"
	imageLink = "Hermit"
	cardCost = 5
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Divine Upbringing"

func getCardDescription() -> String:
	return "Reduce all incoming damage by 1 for all allies, once per turn."
