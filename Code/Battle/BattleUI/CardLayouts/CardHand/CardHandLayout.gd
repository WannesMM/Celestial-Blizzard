extends CardLayout

class_name CardHandLayout

func cardLayoutConstructor():
	cardHandConstructor()
	ARRAY_WIDTH = 700
	CARD_SCALE = 1
	CARD_LAYOUT_TYPE = "CardHand"

func cardHandConstructor():
	pass
	
func addCards(cards: Array[Card]):
	super.addCards(cards)
	for card in cards:
		card.addedToHand(player)
