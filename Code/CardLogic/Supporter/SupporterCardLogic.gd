extends CardLogic

class_name SupporterCardLogic

func cardConstructor():
	cardType = "SupporterCard"
	supporterCardConstructor()

func supporterCardConstructor():
	pass

# Actual Functionality ---------------------------------------------------------

func playableOn():
	return cardOwner.areaSupportCards.collision

#-------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Defaultname"

func getCardDescription() -> String:
	return "Defaultdescription"
