extends Effect

func effectConstructor():
	effectName = "Segmentation"
	timeFrames = ["Start of Round"]
	image = "DQMall"
	
func executeEffect(timeFrame: String = ""):
	applicator.flashCard()
	var gold = applicator.cardOwner.battleResources.gold
	if gold < 6:
		applicator.cardOwner.gainGold(2)
	if gold < 8:
		applicator.cardOwner.drawCards(1)
	if gold < 10:
		applicator.cardOwner.activeCharacter.gainEnergy()
