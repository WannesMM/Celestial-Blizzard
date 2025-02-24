extends Node

class_name InputHandler

var layoutManager: LayoutManager = null

func _init(layoutMan: LayoutManager) -> void:
	layoutManager = layoutMan
	
func selectCards(cards, amount, message):
	pass

func chooseAction():
	pass

func chooseActiveCharacter():
	pass

func convertToCardLogic(cards):
	var cardLogic: Array[CardLogic] = []
	for card in cards:
		cardLogic.append(card.getCardLogic())
	return cardLogic
		
func convertToCard(cards):
	var cardScene: Array[Card] = []
	for card in cards:
		cardScene.append(card.getCard())
	return cardScene
