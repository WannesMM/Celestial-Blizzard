extends Node

class_name CardLogic

#-----------------------------------------------------------------------------------

var card: Card = null

var cardName: String = "Name Unknown"
var cardType: String = "Type Unknown"
var cardCost: int = 1
var imageLink: String = "Card Unknown"

var cardOwner: PlayerState = null
var gameState: GameState = null

func _init() -> void:
	cardConstructor()
	
func cardConstructor():
	pass

# Gamefunctionality ------------------------------------------------------------

# Code that triggers when the card is played, to be extended
func playCard():
	pass

# This returns the layouts that this card is playable on
func playableOn():
	pass

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

# Battle functionality ---------------------------------------------------------

func checkCost(req: int):
	if req > cardOwner.battleResources.gold:
		cardOwner.gameState.layoutManager.message("Not enough Gold")
		return false
	else:
		return true

func attack(dmg: int):
	cardOwner.damage(self, dmg)
