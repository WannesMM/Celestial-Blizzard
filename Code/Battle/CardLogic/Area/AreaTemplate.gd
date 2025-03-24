extends AreaCard

func areaCardConstructor():
	cardName = "CardName"
	imageLink = "Imagelink"
	cardCost = 3
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Effectname"

func getCardDescription() -> String:
	return "EffectDescription"

func playCardLogic():
	Random.message("This card is yet to be implemented")
