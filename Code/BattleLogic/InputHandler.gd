extends Node

class_name InputHandler

var layoutManager: LayoutManager = null

func _init(layoutMan: LayoutManager) -> void:
	layoutManager = layoutMan
	
func selectCards(cards, amount):
	pass

func convertToCardLogic(cards):
	var cardLogic: Array[CardLogic] = []
	for card in cards:
		cardLogic.append(card.getCardLogic())
	return cardLogic
		
