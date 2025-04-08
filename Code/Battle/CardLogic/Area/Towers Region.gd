extends AreaCard

class_name TowersRegion

func areaCardConstructor():
	cardName = "Towers Region"
	imageLink = "Towers Region"
	cardCost = 3
	sampleColor = Color.DARK_SLATE_GRAY
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Secrets of the Dark Forest"

func getCardDescription() -> String:
	return "When on of your characters' move deals no damage, gain 1 gold."

func playCardLogic(layout):
	Effect_Recall.new(self,self,[Event_CharacterUsesMove.new()],towersEffect)

func towersEffect(event):
	var currentEvent: Event_CharacterUsesMove = event
	if currentEvent.character.getMoveDamage(currentEvent.move) == 0 and currentEvent.character.cardOwner == cardOwner:
		flashCard()
		cardOwner.gainGold(1)
