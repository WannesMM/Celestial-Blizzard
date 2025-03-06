extends AreaCardLogic

class_name Berlaar

func areaCardConstructor():
	cardName = "Berlaar"
	imageLink = "Berlaar"
	cardCost = 3
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "From the ashes"

func getCardDescription() -> String:
	return "When you deal burning damage to the opponent, draw a card"

func playCardLogic():
	gameState.scheduleEffect(BerlaarEffect.new(self, self))
	
