extends CardLogic

class_name SupporterCardLogic

func cardConstructor():
	cardType = "SupporterCard"
	supporterCardConstructor()

func supporterCardConstructor():
	pass

# Actual Functionality ---------------------------------------------------------

func playableOn():
	var collisions = []
	for card in cardOwner.areaSupportCards.addedCards:
		collisions.append(card.collision)
	return collisions

#-------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Defaultname"

func getCardDescription() -> String:
	return "Defaultdescription"
