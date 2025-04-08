extends Card

class_name AreaCard

var amountSupporter: int = 1

func cardConstructor():
	cardType = "AreaCard"
	areaCardConstructor()

func areaCardConstructor():
	pass

# Actual functionality ---------------------------------------------------------

func playableOn():
	return [cardOwner.areaSupportCards.collision]

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
	return "This area does nothing besides existing"

func allowMoreSupporters():
	return relatedCards.size() < amountSupporter
