extends AreaCard

class_name NomaMountains

func areaCardConstructor():
	cardName = "Noma Mountains"
	imageLink = "Noma Gebergte"
	cardCost = 2
	sampleColor = Color.CORNFLOWER_BLUE
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Noma Research"

func getCardDescription() -> String:
	return "At the start of the next 2 rounds, draw an additional 2 cards."

var counter = 2

func playCardLogic(layout):
	Effect_Recall.new(self,self,[Event_StartOfRound.new()],drawCards)
	
func drawCards():
	cardOwner.drawCards(2)
	counter -= 1
	if counter <= 0:
		discard()
