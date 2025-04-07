extends SupporterCard

class_name PhoenixHatchling

func supporterCardConstructor():
	cardName = "Phoenix Hatchling"
	imageLink = "Phoenix"
	cardCost = 3
	sampleColor = Color.FIREBRICK
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Monster Mayhem"

func getCardDescription() -> String:
	return "Upon placing it on an area, destroy this and the phoenix hatchling. Deal 2 + the cost of the removed building damage on the opponent."

func playCardLogic(layout):
	assert(layout is AreaCard)
	var builtCard: AreaCard = layout
	var buildingCost = builtCard.cardCost
	attack(2 + buildingCost)
	builtCard.discard()
	self.discard()
	
