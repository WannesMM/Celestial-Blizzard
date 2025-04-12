extends EventCard

class_name BurningMemories

func eventCardConstructor():
	cardName = "Burning Memories"
	imageLink = "Burning Memories"
	cardCost = 0
	sampleColor = Color.FIREBRICK
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Justice is Injustice"

func getCardDescription() -> String:
	return "This card cannot be played. If this card is in your hand at the end of the round, apply 2 burning to the active character."

func playableOn():
	return []

func addedToHand(player: PlayerState):
	super.addedToHand(player)
	Effect_Recall.new(self,self,[Event_EndOfRound.new()],applyBurn,preload("res://assets/Icons/Gear Icon.png"))
	
func applyBurn(event):
	if currentLayout is CardHandLayout:
		Effect_Burning.new(cardOwner.activeCharacter,cardOwner.activeCharacter,2)
		delete()
	else:
		delete()
