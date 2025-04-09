extends CharacterCard

class_name Kin

func characterCardConstructor():
	cardName = "Kin"
	imageLink = "Kin"
	sampleColor = Color.DARK_ORANGE
	
	maxHP = 7
	HP = 7
	maxEnergy = 2
	energy = 0
	NAdmg = 2
	NAcost = 2
	SAdmg = 0
	SAcost = 3
	CAdmg = 0
	CAcost = 3
	CAenergyCost = 2
	
	cardCost = 1

#-------------------------------------------------------------------------------

func SA():
	gainEnergy(1)
	cardOwner.reduceGold(SAcost)
	cardOwner.opponent.deck.stackAddMultipleToBottom([cardOwner.opponent.createCard("Burning Memories"),cardOwner.opponent.createCard("Burning Memories"),cardOwner.opponent.createCard("Burning Memories")])
	cardOwner.opponent.deck.shuffleStack()
	await cardOwner.chooseActiveCharacter()
	
var damageReducedEnemies: Array[CharacterCard] = []
	
func CA():
	cardOwner.reduceGold(CAcost)
	reduceEnergy()
	receiveDamage(2)
	for character: CharacterCard in cardOwner.opponent.characterCards.addedCards:
		for effect: Effect in character.appliedEffects:
			if effect is Effect_Burning:
				character.damageReduction -= 1
				damageReducedEnemies.append(character)
	Effect_Recall.new(self,self,[Event_StartOfRound.new()],removeDamageReduction,preload("res://assets/Icons/Nerf Icon.png"))
	
func removeDamageReduction(event):
	for character: CharacterCard in damageReducedEnemies:
		character.damageReduction += 1

func setActive(x: bool):
	super.setActive(x)
	cardOwner.opponent.deck.stackAddMultipleToBottom([cardOwner.opponent.createCard("Burning Memories"),cardOwner.opponent.createCard("Burning Memories")])
	
#-------------------------------------------------------------------------------

func getNAName() -> String:
	return "Pummel"
	
func getSAName() -> String:
	return "Burning hatred"
	
func getCAName() -> String:
	return "Love burns brightest"
	
func getAbilityName() -> String:
	return "Forgotten memories"
	
func getNADescription() -> String:
	return "Kin flails around, dealing 2dmg"

func getSADescription() -> String:
	return "Shuffle an additional 3 burning memories in the opponent's deck and switch this character out."
	
func getCADescription() -> String:
	return "Kin takes 2dmg, all enemies affected by burning have their incoming damage increased by 1 during this round"
	
func getAbilityDescription() -> String:
	return "When Kin is switched into, put 2 burning memories in the opponent's deck."

func getSP1Name() -> String:
	return "Sacrifice"

func getSP1Description() -> String:
	return "When using love burns brightest, instead of losing 2HP, lose all your HP and heal an ally for all HP lost"

func getSP2Name() -> String:
	return "Shared hate"
	
func getSP2Description() -> String:
	return "When damaging Kin, the target has 1 burning applied to them"
