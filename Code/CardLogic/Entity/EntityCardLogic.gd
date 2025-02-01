extends CardLogic

class_name EntityCardLogic

func cardConstructor():
	cardType = "EntityCard"
	entityCardConstructor()

func entityCardConstructor():
	pass

#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Defaultname"

func getCardDescription() -> String:
	return "Defaultdescription"
