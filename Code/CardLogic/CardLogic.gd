extends Node

class_name CardLogic

#-----------------------------------------------------------------------------------

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
