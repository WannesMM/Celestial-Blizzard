extends EventCard

class_name GreonsCookingPot

func eventCardConstructor():
	cardName = "Greon's Cooking Pot"
	imageLink = "Greon's Cooking Pot"
	cardCost = 1
	sampleColor = Color.SLATE_GRAY
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Unintended brilliance"

func getCardDescription() -> String:
	return "Your active character gains 3HP shield that expires at the end of the round."
