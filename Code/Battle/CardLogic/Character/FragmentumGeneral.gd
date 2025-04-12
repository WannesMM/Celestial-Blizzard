extends CharacterCard

class_name FragmentumGeneral

func characterCardConstructor():
	cardName = "Fragmentum General"
	imageLink = "Fragmentum General"
	sampleColor = Color.CADET_BLUE
	
	maxHP = 10
	HP = 10
	maxEnergy = 3
	energy = 3
	NAdmg = 2
	NAcost = 2
	SAdmg = 0
	SAcost = 3
	CAdmg = 5
	CAcost = 3
	CAenergyCost = 3
	
	cardCost = 1
#-------------------------------------------------------------------------------

var target: CharacterCard
var seal: Effect_Seal
var switch: Effect_Recall

func SA():
	cardOwner.reduceGold(SAcost)
	var cards = await cardOwner.getInputhandler().chooseTarget(cardOwner.characterCards.addedCards, 1, "Choose the ally to approve")
	target = cards[0]
	if seal:
		seal.remove()
	if switch:
		switch.remove()
	seal = Effect_Seal.new(self,target,2)
	switch = Effect_Recall.new(self,target,[Event_CharacterTakesDamage.new(target)], ability,preload("res://assets/Icons/Buff Icon.png"))
	gainEnergy()
	
func ability(event: Event_CharacterTakesDamage):
	if target == event.character:
		if target.HP < 4 and target.active:
			await target.cardOwner.chooseActiveCharacter()
			switch.remove()
	
func CA():
	cardOwner.reduceGold(CAcost)
	reduceEnergy()
	await attack(CAdmg)
	var character = await cardOwner.opponent.chooseActiveCharacter()

func getTargetName():
	if target:
		return target.cardName
	else:
		return "No seal applied"

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
	return "The general gives his mark of approval to an ally. This mark will reduce all incoming damage by 1 for 2 rounds."
	
func getCADescription() -> String:
	return "The general shoots an enhanced bullet that deals 5 damage and switches to opponent out."
	
func getAbilityDescription() -> String:
	return "When the ally that was last sealed for approval falls below 4 HP, switch them out instantly to a character of choice."

func getSP1Name() -> String:
	return "Branding mark"

func getSP1Description() -> String:
	return "When fragmentum general is defeated, apply 3 burning to the enemy"

func getSP2Name() -> String:
	return "Deportation"
	
func getSP2Description() -> String:
	return "Enemies hit by tranquiliser bullet will take 1 additional damage each turn during this round."
