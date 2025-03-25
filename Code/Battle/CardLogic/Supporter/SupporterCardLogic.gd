extends Card

class_name SupporterCard

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

func getDisplayInfo():
	return [
["Title", cardName],
["Portrait", cardImage],
["Title", getEffectName()],
["Text", getCardDescription()]
]

func getEffectName() -> String:
	return "Defaultname"

func getCardDescription() -> String:
	return "Defaultdescription"
