extends CharacterCardLogic

class_name NomaGreon

func characterCardConstructor():
	cardName = "Noma Greon"
	imageLink = "Noma Greon - skin1"
	
	maxHP = 10
	HP = 10
	maxEnergy = 3
	energy = 0
	NAdmg = 1
	NAcost = 2
	SAdmg = 0
	SAcost = 2
	CAdmg = 4
	CAcost = 3
	CAenergyCost = 3

#-------------------------------------------------------------------------------

func getNAName() -> String:
	return "Metal Punch"
	
func getSAName() -> String:
	return "Technical Insight"
	
func getCAName() -> String:
	return "Armor Bash"
	
func getAbilityName() -> String:
	return "Armorer"
	
func getNADescription() -> String:
	return "Greon delivers a metallic strike dealing 1 dmg"

func getSADescription() -> String:
	return "Draw 3 cards from your deck. If artificer armor is one of these cards, equip it instantly without cost. Otherwise, choose a card and place it in your hand."
	
func getCADescription() -> String:
	return "This ability deals 1 additional damage for every equipped piece of armor."
	
func getAbilityDescription() -> String:
	return "If Greon is one of the character cards in your deck, an additional 3 artificer armor cards will be added. In addition to artificer armor's effect, Greon will receive +1dmg for each piece of artificer armor equipped (max 3)"

func getSP1Name() -> String:
	return "Beyond technical"

func getSP1Description() -> String:
	return "Greon can now equip 5 artificer armor cards instead of 3"

func getSP2Name() -> String:
	return "Technical improv"
	
func getSP2Description() -> String:
	return "Greon starts with 1 artificer armor equipped"
