extends Node

class_name CardLogic

#-----------------------------------------------------------------------------------

var cardName: String = "Card Unknown"
var cardType: String = "Type Unknown"

func _init() -> void:
	cardConstructor()
	
func cardConstructor():
	pass

func getCardName():
	return cardName
	
func getCardType():
	return cardType
