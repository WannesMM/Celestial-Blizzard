extends GridCardLayout


func cardLayoutConstructor():
	addCards(Load.loadCards(UserInfo.getDeck()))
	
