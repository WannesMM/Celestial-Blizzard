extends GridCardLayout


func cardLayoutConstructor():
	addCards(Load.loadCards(UserInfo.getEnabledCards().filter(func(x): return x not in UserInfo.getDeck())))
