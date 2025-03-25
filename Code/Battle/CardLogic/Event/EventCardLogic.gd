extends Card

class_name EventCard

func cardConstructor():
	cardType = "EventCard"
	eventCardConstructor()

func eventCardConstructor():
	pass

# Actual functionality ---------------------------------------------------------

func playableOn():
	return [cardOwner.gameState.layoutManager.eventCardCollision]

#-------------------------------------------------------------------------------

func getDisplayInfo():
	return [
["Title", cardName],
["Portrait", cardImage],
["Title", getEffectName()],
["Text", getCardDescription()]
]

func getEffectName() -> String:
	return "Default effect"

func getCardDescription() -> String:
	return "This event does nothing besides existing"
