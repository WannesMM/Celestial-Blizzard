extends GridCardLayout


func cardLayoutConstructor():
	addCards(Load.loadCards(["Torinn Inn", "Bartholomew Balderstone", "Noma Greon"]))
	for card: Card in addedCards:
		card.currentLayout.setMovable(false)
