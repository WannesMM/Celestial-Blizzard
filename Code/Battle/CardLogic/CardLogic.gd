extends Card

class_name CardLogic

#-----------------------------------------------------------------------------------

var card: Card = self

var cardName: String = "Name Unknown"
var cardType: String = "Type Unknown"
var cardCost: int = 1
var imageLink: String = "Card Unknown"

var cardOwner: PlayerState = null
var gameState: GameState = null

var appliedEffects: Array[Effect] = []

func _init() -> void:
	cardConstructor()
	
func cardConstructor():
	pass

# Gamefunctionality ------------------------------------------------------------

var targetable: bool = true

# Code that triggers when the card is played, to be extended
func playCard():
	playCardLogic()
	
func playCardLogic():
	pass

# This returns the layouts that this card is playable on
func playableOn():
	pass

func checkCost(req: int):
	if req > cardOwner.battleResources.gold:
		cardOwner.gameState.layoutManager.message("Not enough Gold")
		return false
	else:
		return true

func attack(dmg: int):
	await cardOwner.damage(self, dmg)

func addEffect(effect: Effect):
	appliedEffects.append(effect)
	card.addEffect(effect)

func removeEffect(effect: Effect):
	appliedEffects.erase(effect)
	effect.removeEffect()
	
func removeAllEffects():
	for effect in appliedEffects:
		removeEffect(effect)

# Getters and Setters ----------------------------------------------------------

func getCardName():
	return cardName
	
func getCardType():
	return cardType

func getImageLink():
	return imageLink

func getCard():
	return card
	
func setCard(cardToAssign):
	card = cardToAssign

func getCardCost():
	return cardCost
	
func setCardCost(cost):
	cardCost = cost

func setCardOwner(player: PlayerState):
	cardOwner = player
	
func getCardOwner(player: PlayerState):
	return cardOwner
