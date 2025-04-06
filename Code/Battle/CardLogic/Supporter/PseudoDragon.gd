extends SupporterCard

class_name PseudoDragon

func supporterCardConstructor():
	cardName = "Pseudo Dragon"
	imageLink = "PseudoDragon"
	cardCost = 3
	sampleColor = Color.DARK_ORANGE
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Monster Mayhem"

func getCardDescription() -> String:
	return "Apply 1 burning to the opponent on placement and at the start of each round."

func playCardLogic():
	attack(1)
	Effect_Recall.new(self,self,[Event_StartOfRound.new()],flame)
	
func flame():
	flashCard()
	attack(1)
