extends Card

class_name EquipmentCard

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
