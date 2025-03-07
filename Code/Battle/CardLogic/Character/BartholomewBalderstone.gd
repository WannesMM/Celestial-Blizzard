extends CharacterCard

class_name BartholomewBalderstone

func characterCardConstructor():
	cardName = "Bartholomew Balderstone"
	imageLink = "Bartholomew Balderstone"

	maxHP = 10
	HP = 10
	maxEnergy = 2
	energy = 0
	NAdmg = 1
	NAcost = 2
	SAdmg = 0
	SAcost = 3
	CAdmg = 5
	CAcost = 4
	CAenergyCost = 2
	
	cardCost = 2

#-------------------------------------------------------------------------------

func getNAName() -> String:
	return "Racket"
	
func getSAName() -> String:
	return "Demonic Eye"
	
func getCAName() -> String:
	return "Eldrich Blast"
	
func getAbilityName() -> String:
	return "Eldrich Spear"
	
func getNADescription() -> String:
	return "Bartholomew attacks by using his magic-tennis expertise, dealing 1dmg."

func getSADescription() -> String:
	return "Choose a character to be afflicted with a mark. Bartholomew will now only target this enemy. Marked enemies take +1dmg from all sources (once per turn)"
	
func getCADescription() -> String:
	return "Bartholomew uses his signature move: ELDRICH BLAST, dealing 4dmg and enhancing his next racket attack with +1 bonus damage"
	
func getAbilityDescription() -> String:
	return "When Bartholomew deals damage to an enemy that is not the current active character, he will deal +1 damage."

func getSP1Name() -> String:
	return "Demonic precision"

func getSP1Description() -> String:
	return "Bartholomew can now switch the target of demonic eye without ending his turn"

func getSP2Name() -> String:
	return "Demonic negotiations"
	
func getSP2Description() -> String:
	return "Bartholomew can now use demonic eye without any cost, once every round"
