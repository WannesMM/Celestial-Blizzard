extends EventCardLogic

class_name Ballista

func eventCardConstructor():
	cardName = "Ballista"
	imageLink = "Ballista"
	cardCost = 3
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Anti-Wolf Warfare"

func getCardDescription() -> String:
	return "Summon 3 silver arrows in your hand."
