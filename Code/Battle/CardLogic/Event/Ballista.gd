extends EventCard

class_name Ballista

func eventCardConstructor():
	cardName = "Ballista"
	imageLink = "Ballista"
	cardCost = 3
	sampleColor = Color.SEA_GREEN
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Anti-Wolf Warfare"

func getCardDescription() -> String:
	return "Summon 3 silver arrows in your hand."
