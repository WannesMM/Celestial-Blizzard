extends CardLogic

class_name SupporterCardLogic

func cardConstructor():
	cardType = "SupporterCard"
	supporterCardConstructor()

func supporterCardConstructor():
	pass

#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Defaultname"

func getCardDescription() -> String:
	return "Defaultdescription"
