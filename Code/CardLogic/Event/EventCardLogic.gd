extends CardLogic

class_name EventCardLogic

func cardConstructor():
	cardType = "EventCard"
	eventCardConstructor()

func eventCardConstructor():
	pass

# Actual functionality ---------------------------------------------------------

func playableOn():
	return cardOwner.gameState.layoutManager.eventCardCollision

#-------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Default effect"

func getCardDescription() -> String:
	return "This event does nothing besides existing"
