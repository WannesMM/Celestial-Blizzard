extends AreaCardLogic

class_name DQMall

func areaCardConstructor():
	cardName = "DQ Mall"
	imageLink = "DQ Mall"
	cardCost = 4
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Segmentation"

func getCardDescription() -> String:
	return "Depending on the amount of gold you posess at the start of each round, gain one or more of the following benefits:
		<6 --> Gain 2 gold
		<8 --> Gain 1 card
		<10 --> Gain 1 energy on the active character"

func playCardLogic():
	gameState.scheduleEffect(Effect_Segmentation.new(self,self))
