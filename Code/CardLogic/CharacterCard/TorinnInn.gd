extends CharacterCardLogic

class_name TorinnInn

func characterCardConstructor():
	cardName = "Torinn Inn"
	imageLink = "Torinn Inn test"
	
	var maxHP: int = 10
	var HP: int = 10
	var maxEnergy: int = 3
	var energy: int = 0
	var NAdmg: int = 2
	var NAcost: int = 2
	var SAdmg: int = 0
	var SAcost: int = 3
	var CAdmg: int = 0
	var CAcost: int = 3
	var CAenergyCost: int = 3

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
	
