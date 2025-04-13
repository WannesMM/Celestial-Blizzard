extends GridCardLayout


func cardLayoutConstructor():
	addCards(Load.loadCards(UserInfo.getCharacters()))
	for card: Card in addedCards:
		card.currentLayout.setMovable(true)
