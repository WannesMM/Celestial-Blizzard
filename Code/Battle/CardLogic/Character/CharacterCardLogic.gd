extends Card

class_name CharacterCard

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

var damageReduction: int = 0

func cardConstructor():
	cardType = "CharacterCard"
	
	characterCardConstructor()

func characterCardConstructor():
	pass

# Actual Functionality -----------------------------------------------------------------------------

func setActive(x: bool):
	active = x
	if active:
		moveCardUpSelect(ACTIVECHARMOVEMENT)
	else:
		moveCardDownSelect()

func playableOn():
	return [cardOwner.characterCards.collision]

var NABonusDamage: int = 0

func NA():
	cardOwner.reduceGold(NAcost)
	gainEnergy()
	await attack(NAdmg + NABonusDamage)
	
func SA():
	cardOwner.reduceGold(SAcost)
	gainEnergy()
	await attack(SAdmg)
	
func CA():
	cardOwner.reduceGold(CAcost)
	reduceEnergy()
	await attack(CAdmg)

func onMove(attackType: String):
	gameState.layoutManager.camera.zoomGlobal(global_position, 1.7, 1)
	
	await Load.announce(cardName + " uses " + getMoveName(attackType))
	
	gameState.layoutManager.camera.zoom(Vector2(0,0), 1, 1.5)

func receiveDamage(amt: int):
	var receivedAmount = amt - damageReduction
	
	var anim = Load.loadAnimation("Take Damage")
	anim.setText("- " + str(receivedAmount))
	anim.setPosition(global_position)
	anim.setColor(Color.MAROON)
	await Load.playAnimation(anim)
	
	await setHP(HP - receivedAmount)
	await gameState.executeEffects("Specific Character Takes Damage", self)
	onHit()
	
func onHit():
	pass
	
func defeatCard(card = self):
	card.defeated = true
	card.targetable = false
	card.removeAllEffects()
	await gameState.characterDefeated(card, card.cardOwner)
	
func isPossibleMove(move: String):
	if active:
		return true
	gameState.layoutManager.message("This character is not currently active")
	return false
	
func gainEnergy(amt: int = 1):
	if energy + amt > maxEnergy:
		energy = maxEnergy
	else:
		energy += amt
	
func getMoveCost(move: String):
	match move:
		"NA":
			return NAcost
		"SA":
			return SAcost
		"CA":
			return CAcost

func getMoveName(move: String):
	match move:
		"NA":
			return getNAName()
		"SA":
			return getSAName()
		"CA":
			return getCAName()

func checkEnergy():
	if energy >= CAenergyCost:
		return true
	else:
		return false
		
func reduceEnergy():
	energy = energy - CAenergyCost
	
func heal(amt: int):
	var anim = Load.loadAnimation("Take Damage")
	anim.setText("+ " + str(amt))
	anim.setPosition(global_position)
	anim.setColor(Color.AQUA)
	await Load.playAnimation(anim)
	
	setHP(HP + amt)
	
func getDisplayInfo():
	return [
["Title", cardName],
["Portrait", cardImage],
["Parameter", getHP(), 0, getMaxHP()],
["Parameter", getEnergy(), 0, getMaxEnergy(), Color.LIGHT_STEEL_BLUE],
["Button", getNAName()],
["Text", getNADescription()],
["Button", getSAName()],
["Text", getSADescription()],
["Button", getCAName()],
["Text", getCADescription()],
["Title", getAbilityName()],
["Text", getAbilityDescription()]
]

#---------------------------------------------------------------------------------------------------

func setCost(cost: int):
	cardCost = cost

func getMaxHP():
	return maxHP

func setHP(amt: int):
	if amt > maxHP:
		HP = maxHP
	elif amt <= 0:
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
		card.setLabel1Color(Color.MAROON)
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
