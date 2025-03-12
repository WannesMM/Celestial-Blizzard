extends AreaCard

func areaCardConstructor():
	cardName = "Nieuwtoren"
	imageLink = "Nieuwtoren"
	cardCost = 3
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Lost by justice"

func getCardDescription() -> String:
	return "Destroy every supporter and region card on the arena, both yours and your opponent's and replace them with an Ashen Remains card"

func playCardLogic():
	for card in cardOwner.getAreaSupportCards().addedCards:
		cardOwner.deleteCard(card)
		var ashenRemains = Load.loadCard("Ashen Remains")
		ashenRemains.setCardOwner(cardOwner)
		cardOwner.getAreaSupportCards().addCard(ashenRemains)
	
	for card in cardOwner.getAreaSupportCards().addedCards:
		cardOwner.opponent.deleteCard(card)
		var ashenRemains = Load.loadCard("Ashen Remains")
		ashenRemains.setCardOwner(cardOwner.opponent)
		cardOwner.opponent.getAreaSupportCards().addCard(ashenRemains)
