extends Effect

class_name Effect_Segmentation

func effectConstructor():
	effectName = "Segmentation"
	timeFrame = "Start of Round"
	image = "DQMall"
	
func executeEffect():
	var gold = applicator.cardOwner.battleResources.gold
	if gold < 6:
		applicator.cardOwner.gainGold(2)
	if gold < 8:
		applicator.cardOwner.drawCards(1)
	if gold < 10:
		applicator.cardOwner.activeCharacter.cardLogic.gainEnergy()
