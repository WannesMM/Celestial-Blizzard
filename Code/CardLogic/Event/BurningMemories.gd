extends EventCardLogic

class_name BurningMemories

func eventCardConstructor():
	cardName = "Burning Memories"
	imageLink = "Burning Memories"
	cardCost = 0
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Justice is Injustice"

func getCardDescription() -> String:
	return "This card cannot be played. If this card is in your hand at the end of the round, apply 2 burning to the active character."
