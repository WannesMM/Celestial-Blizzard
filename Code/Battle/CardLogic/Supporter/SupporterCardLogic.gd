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
	for card: AreaCard in cardOwner.areaSupportCards.addedCards:
		if card.amountSupporter > card.relatedCards.size():
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
