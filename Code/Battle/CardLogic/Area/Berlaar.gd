extends AreaCard

func areaCardConstructor():
	cardName = "Berlaar"
	imageLink = "Berlaar"
	cardCost = 3
	sampleColor = Color.DARK_SALMON
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "From the ashes"

func getCardDescription() -> String:
	return "When you deal burning damage to the opponent, draw a card"

func playCardLogic(layout):
	Effect_BurningDraw.new(self,self)
	
