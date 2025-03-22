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
	return "When a characters' move deals no damage, gain 1 gold."
