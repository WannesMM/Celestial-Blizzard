extends EventCard

class_name SilverArrow

func eventCardConstructor():
	cardName = "Silver Arrow"
	imageLink = "Silver Arrow"
	cardCost = 0
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Anti-Wolf Warfare"

func getCardDescription() -> String:
	return "Deal 1 damage to the active enemy character. If this enemy is demonic, they will deal 1 reduced damage this turn."
