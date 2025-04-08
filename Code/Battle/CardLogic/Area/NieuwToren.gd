extends AreaCard

func areaCardConstructor():
	cardName = "Nieuwtoren"
	imageLink = "Nieuwtoren"
	cardCost = 3
	sampleColor = Color.LIGHT_SEA_GREEN
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Lost by justice"

func getCardDescription() -> String:
	return "Destroy every supporter and region card on the arena, both yours and your opponent's and replace them with an Ashen Remains card"

func playCardLogic(layout):
	for card: Card in cardOwner.getAreaSupportCards().addedCards.duplicate(false):
		card.discard()
		var ashenRemains: Card = Load.loadCard("Ashen Remains")
		ashenRemains.setCardOwner(cardOwner)
		cardOwner.getAreaSupportCards().addCard(ashenRemains)
	
	for card in cardOwner.opponent.getAreaSupportCards().addedCards.duplicate(false):
		card.discard()
		var ashenRemains = Load.loadCard("Ashen Remains")
		ashenRemains.setCardOwner(cardOwner.opponent)
		cardOwner.opponent.getAreaSupportCards().addCard(ashenRemains)
