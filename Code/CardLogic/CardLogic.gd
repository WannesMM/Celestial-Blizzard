extends Node

class_name CardLogic

#-----------------------------------------------------------------------------------

var card: Card = null

var cardName: String = "Name Unknown"
var cardType: String = "Type Unknown"
var cardCost: int = 1
var imageLink: String = "Card Unknown"

func _init() -> void:
	cardConstructor()
	
func cardConstructor():
	pass

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
