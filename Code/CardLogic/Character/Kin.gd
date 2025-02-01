extends CharacterCardLogic

class_name Kin

func characterCardConstructor():
	cardName = "Kin"
	imageLink = "Kin"
	
	maxHP = 7
	HP = 7
	maxEnergy = 2
	energy = 0
	NAdmg = 2
	NAcost = 2
	SAdmg = 0
	SAcost = 3
	CAdmg = 0
	CAcost = 3
	CAenergyCost = 2

#-------------------------------------------------------------------------------

func getNAName() -> String:
	return "Pummel"
	
func getSAName() -> String:
	return "Burning hatred"
	
func getCAName() -> String:
	return "Love burns brightest"
	
func getAbilityName() -> String:
	return "Forgotten memories"
	
func getNADescription() -> String:
	return "Kin flails around, dealing 2dmg"

func getSADescription() -> String:
	return "Shuffle an additional 3 burning memories in the opponent's deck and switch this character out."
	
func getCADescription() -> String:
	return "Kin takes 2dmg, all enemies affected by burning have their incoming damage increased by 1"
	
func getAbilityDescription() -> String:
	return "When Kin is switched into, put 2 burning memories in the opponent's deck."
