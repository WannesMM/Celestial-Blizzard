extends Card

class_name EquipmentCard

func cardConstructor():
	cardType = "SupporterCard"
	equipmentCardConstructor()

func equipmentCardConstructor():
	pass

#---------------------------------------------------------------------------------------------------

func getDisplayInfo():
	return [
["Title", cardName],
["Portrait", cardImage],
["Parameter"],
["Title", getEffectName()],
["Text", getCardDescription()]
]

func getEffectName() -> String:
	return "Defaultname"

func getCardDescription() -> String:
	return "Defaultdescription"
