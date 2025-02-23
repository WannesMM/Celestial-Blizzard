extends CharacterCardLogic

class_name CharacterTemplate

func characterCardConstructor():
	cardName = "Name"
	imageLink = "Link"
	
	maxHP = 10
	HP = 10
	maxEnergy = 3
	energy = 0
	NAdmg = 2
	NAcost = 2
	SAdmg = 3
	SAcost = 3
	CAdmg = 6
	CAcost = 3
	CAenergyCost = 3

#-------------------------------------------------------------------------------

func getNAName() -> String:
	return ""
	
func getSAName() -> String:
	return ""
	
func getCAName() -> String:
	return ""
	
func getAbilityName() -> String:
	return ""
	
func getNADescription() -> String:
	return ""

func getSADescription() -> String:
	return ""
	
func getCADescription() -> String:
	return ""
	
func getAbilityDescription() -> String:
	return ""

func getSP1Name() -> String:
	return ""

func getSP1Description() -> String:
	return ""

func getSP2Name() -> String:
	return ""
	
func getSP2Description() -> String:
	return ""
