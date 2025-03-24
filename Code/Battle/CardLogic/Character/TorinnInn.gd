extends CharacterCard

func characterCardConstructor():
	cardName = "Torinn Inn"
	imageLink = "Torinn Inn test"
	sampleColor = Color.GOLDENROD
	
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
	
	cardCost = 4

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

func getSP1Name() -> String:
	return "Divine smite"

func getSP1Description() -> String:
	return "When using lay on hands, the next battleaxe attack will deal an additional 2 damage"

func getSP2Name() -> String:
	return "Judgement"
	
func getSP2Description() -> String:
	return "When an area card is destroyed, gain 2 stacks of golden breath"

# BattleFunctionality ----------------------------------------------------------

var goldenBreath: int = 0

func SA():
	cardOwner.reduceGold(SAcost)
	if(goldenBreath != 0):
		var newBurning = Load.loadEffect("Burning", self)
		newBurning.stacks = goldenBreath
		gameState.scheduleEffect(newBurning)
		goldenBreath = 0
	gainEnergy()
	
func CA():
	cardOwner.reduceGold(CAcost)
	reduceEnergy()
	heal(3)
	goldenBreath += 3

var previousTurn
var previousRound

func divineSense():
	if previousTurn != gameState.turnCounter or previousRound != gameState.roundCounter:
		goldenBreath += 1
		gainEnergy()
		previousTurn = gameState.turnCounter
		previousRound = gameState.roundCounter
	
func onHit():
	divineSense()
	
