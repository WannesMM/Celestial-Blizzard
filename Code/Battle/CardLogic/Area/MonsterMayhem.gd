extends AreaCard

func areaCardConstructor():
	cardName = "Monster Mayhem"
	imageLink = "Monster Mayhem"
	cardCost = 3
	sampleColor = Color.DARK_SALMON
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Partners for Life"

func getCardDescription() -> String:
	return "Upon placing this area, one of the following supporters will be summoned: Pseudodragon, Phoenix Hatchling or Blinking Dog"

func playCardLogic(layout):
	flashCard()
	var card: Card = null
	match Random.generateRandom(1,1,3):
		1:
			card = Load.loadCard("Psuedo Dragon")
		2:
			card = Load.loadCard("Phoenix Hatchling")
		3:
			card = Load.loadCard("Blinking Dog")
	card.setCardOwner(cardOwner)
	cardOwner.playCard(card, self)
		
