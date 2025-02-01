extends CardLogic

class_name EquipmentCardLogic

func cardConstructor():
	cardType = "SupporterCard"
	equipmentCardConstructor()

func equipmentCardConstructor():
	pass

#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Defaultname"

func getCardDescription() -> String:
	return "Defaultdescription"
