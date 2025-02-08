extends CardLogic

class_name CharacterCardLogic

var maxHP: int = 10
var HP: int = 10
var maxEnergy: int = 3
var energy: int = 0
var NAdmg: int = 2
var NAcost: int = 2
var SAdmg: int = 3
var SAcost: int = 3
var CAdmg: int = 6
var CAcost: int = 3
var CAenergyCost: int = 3

var active: bool = false

func cardConstructor():
	cardType = "CharacterCard"
	characterCardConstructor()

func characterCardConstructor():
	pass

# Actual Functionality -----------------------------------------------------------------------------

func setActive(x: bool):
	pass
	#active = x
	#card.setActive(x)
	#if active:
		#card.activeAnimation()
	#else:
		#card.disableActiveAnimation

func playableOn():
	return [cardOwner.characterCards.collision]

#---------------------------------------------------------------------------------------------------

func getMaxHP():
	return maxHP

func getHP():
	return HP
	
func getMaxEnergy():
	return maxEnergy
	
func getEnergy():
	return energy
	
func getNAdmg():
	return NAdmg
	
func getNAcost():
	return NAcost
	
func getSAdmg():
	return SAdmg
	
func getSAcost():
	return SAcost
	
func getCAdmg():
	return CAdmg
	
func getCAcost():
	return CAcost
	
func getCAenergyCost():
	return CAenergyCost
	
func getNAName() -> String:
	return "Normal Attack"
	
func getSAName() -> String:
	return "Special Attack"
	
func getCAName() -> String:
	return "Charged Attack"
	
func getAbilityName() -> String:
	return "DefaultAbility"
	
func getNADescription() -> String:
	return "This character deals 2dmg to the active enemy character"

func getSADescription() -> String:
	return "This character deals 3dmg to the active enemy character"
	
func getCADescription() -> String:
	return "This character deals 6dmg to the active enemy character"

func getAbilityDescription() -> String:
	return "This character does nothing"
