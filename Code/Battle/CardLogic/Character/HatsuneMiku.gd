extends CharacterCard

class_name HatsuneMiku

func characterCardConstructor():
	cardName = "Hatsune Miku"
	imageLink = "Hatsune Miku"
	
	maxHP = 7
	HP = 7
	maxEnergy = 3
	energy = 0
	NAdmg = 2
	NAcost = 2
	SAdmg = 0
	SAcost = 7
	CAdmg = 11
	CAcost = 0
	CAenergyCost = 10

#-------------------------------------------------------------------------------

func getNAName() -> String:
	return "Leek"
	
func getSAName() -> String:
	return "Select"
	
func getCAName() -> String:
	return "Miku Miku Beam"
	
func getAbilityName() -> String:
	return "The world"
	
func getNADescription() -> String:
	return "Hatsune Miku attacks using a leek, dealing 1 damage."

func getSADescription() -> String:
	return "Hatsune Miku locks on to the chosen enemy character. As soon as Miku Miku Beam is available, it will be executed on the chosen target"
	
func getCADescription() -> String:
	return "Deal a massive 11 damage to the opponent, unless the target has been set by Select"
	
func getAbilityDescription() -> String:
	return "Hatsune miku gains 2 energy at the start of each round"
