extends AreaCardLogic

class_name AreaTemplate

func areaCardConstructor():
	cardName = "CardName"
	imageLink = "Imagelink"
	cardCost = 3
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Effectname"

func getCardDescription() -> String:
	return "EffectDescription"
