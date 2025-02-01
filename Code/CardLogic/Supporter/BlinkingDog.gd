extends SupporterCardLogic

class_name BlinkingDog

func supporterCardConstructor():
	cardName = "Blinking Dog Puppy"
	imageLink = "Blinking Dog"
	cardCost = 1
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Monster Mayhem"

func getCardDescription() -> String:
	return "The dog will place itself onto an area on the opponent's side as soon as there is one available."
