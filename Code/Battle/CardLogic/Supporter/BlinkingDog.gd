extends SupporterCard

class_name BlinkingDog

func supporterCardConstructor():
	cardName = "Blinking Dog Puppy"
	imageLink = "Blinking Dog"
	cardCost = 1
	sampleColor = Color.LIGHT_CORAL
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Monster Mayhem"

func getCardDescription() -> String:
	return "The dog will place itself onto an area on the opponent's side as soon as there is one available."

var recall: Effect

func playCardLogic():
	var target: Card = null
	for card in cardOwner.opponent.areaSupportCards.addedCards:
		if card.relatedCards == []:
			target = card
	if target:
		moveDog(target)
	else:
		recall = Effect_Recall.new(self,self,[Event_PlayCardType.new("AreaCard")],playCardLogic)
		
func moveDog(target: Card):
	flashCard()
	cardOwner.playSupporter(self,target)
	if recall:
		recall.remove()
	
