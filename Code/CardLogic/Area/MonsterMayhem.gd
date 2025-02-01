extends AreaCardLogic

class_name MonsterMayhem

func areaCardConstructor():
	cardName = "Monster Mayhem"
	imageLink = "Monster Mayhem"
	cardCost = 3
	
#---------------------------------------------------------------------------------------------------

func getEffectName() -> String:
	return "Partners for Life"

func getCardDescription() -> String:
	return "Upon placing this area, one of the following supporters will be summoned: Pseudodragon, Phoenix Hatchling or Blinking Dog"
