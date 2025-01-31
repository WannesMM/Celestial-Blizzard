extends CardLogic

class_name AreaCardLogic

func cardConstructor():
	cardType = "AreaCard"
	AreaCardConstructor()

func AreaCardConstructor():
	pass

#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Default effect"

func getCardDescription() -> String:
	return "This area does nothing besides existing"
