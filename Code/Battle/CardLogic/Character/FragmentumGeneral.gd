extends CharacterCard

class_name FragmentumGeneral

func characterCardConstructor():
	cardName = "Fragmentum General"
	imageLink = "Fragmentum General"
	
	maxHP = 10
	HP = 10
	maxEnergy = 3
	energy = 0
	NAdmg = 2
	NAcost = 2
	SAdmg = 0
	SAcost = 3
	CAdmg = 5
	CAcost = 3
	CAenergyCost = 3
	
	cardCost = 1
#-------------------------------------------------------------------------------

func getNAName() -> String:
	return "Rifle"
	
func getSAName() -> String:
	return "Seal of approval"
	
func getCAName() -> String:
	return "Tranquiliser bullet"
	
func getAbilityName() -> String:
	return "Eject button"
	
func getNADescription() -> String:
	return "The general shoots at the enemy, dealing 2 damage."

func getSADescription() -> String:
	return "The general gives his mark of approval to an ally. This mark will reduce all incoming damage by 1, once per turn for 2 rounds."
	
func getCADescription() -> String:
	return "The general shoots an enhanced bullet that deals 5 damage and switches to opponent out."
	
func getAbilityDescription() -> String:
	return "When the ally with the seal of approval falls below 4 HP, switch them out instantly to a character of choice."

func getSP1Name() -> String:
	return "Branding mark"

func getSP1Description() -> String:
	return "When fragmentum general is defeated, apply 3 burning to the enemy"

func getSP2Name() -> String:
	return "Deportation"
	
func getSP2Description() -> String:
	return "Enemies hit by tranquiliser bullet will take 1 additional damage each turn during this round."
