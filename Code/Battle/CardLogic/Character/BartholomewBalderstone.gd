extends CharacterCard

func characterCardConstructor():
	cardName = "Bartholomew Balderstone"
	imageLink = "Bartholomew Balderstone"
	sampleColor = Color.BROWN

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

var target: CharacterCard = null

func attack(dmg: int):
	if target:
		if target.active == false:
			await cardOwner.damage(self, dmg + damageBonus + 1, target)
		else:
			await cardOwner.damage(self, dmg + damageBonus)
		if target.defeated:
			target = null
	else:
		await cardOwner.damage(self, dmg + damageBonus)

func getTargetName():
	if target:
		return target.cardName
	else:
		return "No Target"

func SA():
	cardOwner.reduceGold(SAcost)
	var cards = await cardOwner.getInputhandler().chooseTarget(cardOwner.opponent.characterCards.addedCards, 1, "Choose the target to mark")
	target = cards[0]
	
	var newHuntersMark = Load.loadEffect("Hunter's Mark", self, -1, target)
	gameState.scheduleEffect(newHuntersMark)
	gainEnergy()
	
var CABuff = false
	
func CA():
	cardOwner.reduceGold(CAcost)
	reduceEnergy()
	CABuff = true
	await attack(CAdmg)

func NA():
	cardOwner.reduceGold(NAcost)
	gainEnergy()
	if CABuff == true:
		await attack(NAdmg + NABonusDamage + 1)
		CABuff = false
	else:
		attack(NAdmg + NABonusDamage)
	

func getDisplayInfo():
	return [
["Title", cardName],
["Portrait", cardImage],
["Parameter", getHP(), 0, getMaxHP()],
["Parameter", getEnergy(), 0, getMaxEnergy(), Color.LIGHT_STEEL_BLUE],
["Title", getTargetName()],
["Button", getNAName()],
["Text", getNADescription()],
["Button", getSAName()],
["Text", getSADescription()],
["Button", getCAName()],
["Text", getCADescription()],
["Title", getAbilityName()],
["Text", getAbilityDescription()]
]

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
