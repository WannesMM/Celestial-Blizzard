extends CardLogic

class_name CharacterCardLogic

var maxHP: int = 10
var HP: int = 10: set = setHP
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
var defeated: bool = false

func cardConstructor():
	cardType = "CharacterCard"
	characterCardConstructor()

func characterCardConstructor():
	pass

# Actual Functionality -----------------------------------------------------------------------------

func setActive(x: bool):
	active = x
	card.setActive(x)

func playableOn():
	return [cardOwner.characterCards.collision]

func NA():
	if checkCost(NAdmg):
		await attack(NAdmg)
	
func SA():
	print("Default SA has been executed")
	
func CA():
	print("Default CA has been executed")
	
func receiveDamage(amt: int):
	await setHP(HP - amt)
	
func defeatCard(card = self):
	card.defeated = true
	await gameState.characterDefeated(card, card.cardOwner)
	
func isPossibleMove(move: String):
	if active:
		return true
	gameState.layoutManager.message("This character is not currently active")
	return false
	
#---------------------------------------------------------------------------------------------------

func getMaxHP():
	return maxHP

func setHP(amt: int):
	if amt <= 0:
		HP = 0
		card.setLabel1(str(HP))
		await defeatCard(self)
	else:
		HP = amt
	if card:
		card.setLabel1(str(HP))
	if HP == 0:
		card.cardShatterStage(4)
	elif HP <= floor((maxHP/6)):
		card.cardShatterStage(3)
	elif HP <= floor((maxHP/3)):
		card.cardShatterStage(2)
	elif HP <= floor((maxHP/2)):
		card.cardShatterStage(1)

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

func getSP1Name() -> String:
	return "Spirit power 1"

func getSP1Description() -> String:
	return "This character has no spirit power1"
	
func getSP2Name() -> String:
	return "Spirit power 2"
	
func getSP2Description() -> String:
	return "This character has no spirit power2"
