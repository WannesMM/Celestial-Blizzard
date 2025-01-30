extends CharacterCardLogic

class_name TorinnInn

func characterCardConstructor():
	cardName = "Torinn Inn"
	imageLink = "Torinn Inn test"
	
	maxHP = 10
	HP = 10
	maxEnergy = 3
	energy = 0
	NAdmg = 2
	NAcost = 2
	SAdmg = 0
	SAcost = 3
	CAdmg = 0
	CAcost = 3
	CAenergyCost = 3

#-------------------------------------------------------------------------------

func getNADescription() -> String:
	return "Torinn Inn uses his battleaxe to clobber his opponent, dealing 2 damage."

func getSADescription() -> String:
	return "Torinn Inn uses his up all his X golden breath stacks to apply X burning to the opponent."
	
func getCADescription() -> String:
	return "Torinn Inn heals 3HP and gains 3 stacks of golden breath."
	
func getAbilityDescription() -> String:
	return "Once per turn, when Torinn is hit gain 1 energy and 1 stack of golden breath."

func getNAName() -> String:
	return "Battleaxe"
	
func getSAName() -> String:
	return "Golden Breath"
	
func getCAName() -> String:
	return "Lay on Hands"
	
func getAbilityName() -> String:
	return "Divine Sense"
	
