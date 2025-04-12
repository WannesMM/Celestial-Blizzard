extends GridCardLayout


func cardLayoutConstructor():
	addCards(Load.loadCards(UserInfo.getEnabledCharacters().filter(func(x): return x not in UserInfo.getCharacters())))
