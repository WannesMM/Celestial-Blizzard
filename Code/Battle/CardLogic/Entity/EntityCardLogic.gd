extends Card

class_name EntityCard

func cardConstructor():
	cardType = "EntityCard"
	entityCardConstructor()

func entityCardConstructor():
	pass

# Actual functionality ---------------------------------------------------------

func playableOn():
	return [cardOwner.entityCards.collision]

#-------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Defaultname"

func getCardDescription() -> String:
	return "Defaultdescription"
