extends Node

var deck = []
var enabledCards = []

func getDeck():
	return deck.duplicate()

func addToDeck(card: String):
	if len(deck) > 60:
		printerr("Exceeded maximum deck size")
		return ERR_PARAMETER_RANGE_ERROR
	deck.append(card)
	
func removeFromDeck(card: String):
	var cardIndex = deck.find(card)
	if cardIndex == -1:
		printerr("Cannot remove card from deck. Card was not in deck.")
		return ERR_DOES_NOT_EXIST

	deck.remove_at(cardIndex)

func enableCard(card:String):
	if not enabledCards.has(card):
		enabledCards.append(card)

func disableCard(card: String):
	var cardIndex = enabledCards.find(card)
	if cardIndex == -1:
		printerr("Cannot disable card from deck. Card was not enabled.")
		return ERR_DOES_NOT_EXIST
		
	deck.remove_at(cardIndex)
